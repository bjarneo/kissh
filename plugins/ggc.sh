#!/bin/bash

# ==============================================================================
# Gemini Conventional Commit Message Generator (`ggc`)
#
# Description:
#   This script defines a function `ggc` that uses the Google Gemini API to
#   generate a conventional commit message (Angular format) based on the
#   unstaged and untracked changes in your git repository.
#
# Prerequisites:
#   1. `git` must be installed.
#   2. `jq` must be installed (for parsing JSON).
#      - On macOS: brew install jq
#      - On Debian/Ubuntu: sudo apt-get install jq
#   3. A Google Gemini API key.
#
# Setup as a Function:
#   1. Obtain a Gemini API key from Google AI Studio: https://aistudio.google.com/
#   2. Set the API key as an environment variable named `GEMINI_API_KEY`.
#      Add the following line to your shell profile (e.g., ~/.bashrc, ~/.zshrc):
#      export GEMINI_API_KEY="YOUR_API_KEY_HERE"
#   3. Save this script as `ggc.sh` in a permanent location (e.g., ~/.local/bin/).
#   4. Add the following line to your shell profile (~/.bashrc, ~/.zshrc) to
#      make the function available in your terminal:
#      source ~/.local/bin/ggc.sh
#   5. Restart your terminal or run `source ~/.bashrc` to apply the changes.
#
# Usage:
#   After setup, navigate to your git repository and simply run:
#   ggc
#
# ==============================================================================

ggc() {
  # --- Pre-flight Checks ---

  # 1. Check if inside a Git repository
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Error: This is not a git repository."
    return 1
  fi

  # 2. Check for the GEMINI_API_KEY environment variable
  if [ -z "$GEMINI_API_KEY" ]; then
    echo "❌ Error: The GEMINI_API_KEY environment variable is not set."
    echo "   Please obtain an API key from Google AI Studio and set it."
    echo "   Example: export GEMINI_API_KEY=\"YOUR_API_KEY_HERE\""
    return 1
  fi

  # 3. Check if jq is installed
  if ! command -v jq &>/dev/null; then
    echo "❌ Error: 'jq' is not installed, but it's required to parse the API response."
    echo "   Please install it. (e.g., 'brew install jq' or 'sudo apt-get install jq')"
    return 1
  fi

  # --- Core Logic ---

  echo "🔎 Analyzing unstaged changes and untracked files..."

  # 1. Get all changes, including unstaged modifications and new untracked files.
  # Get diff for modified (but tracked) files.
  local UNSTAGED_DIFF
  UNSTAGED_DIFF=$(git diff)

  # Get content of new, untracked files and format it like a diff.
  local UNTRACKED_FILES_CONTENT=""
  while IFS= read -r file; do
    # Create a diff-like header for the new file to give context to the AI.
    UNTRACKED_FILES_CONTENT+=$(printf "\n--- /dev/null\n+++ b/%s\n" "$file")
    # Append the file's content, prefixing each line with '+' to simulate a diff.
    UNTRACKED_FILES_CONTENT+=$(sed 's/^/+/' "$file")
  done < <(git ls-files --others --exclude-standard)

  # Combine the diffs
  local GIT_DIFF="${UNSTAGED_DIFF}${UNTRACKED_FILES_CONTENT}"

  # Check if there are any changes at all
  if [ -z "$GIT_DIFF" ]; then
    echo "✅ No unstaged changes or new files found. Nothing to do."
    return 0
  fi

  # 2. Prepare the prompt for the Gemini API
  # The prompt instructs the model to act as an expert and return only the commit message.
  local PROMPT="As an expert programmer, analyze the following git diff and generate a concise, single-line conventional commit message in the Angular format. The message must accurately summarize the changes. Your response should contain ONLY the raw commit message text, without any extra explanations, introductory text, or markdown formatting like backticks."

  # We need to escape the diff content to safely embed it in a JSON payload.
  # 'jq -R -s .' reads the raw string (-R) as a single entity (-s) and formats it as a JSON string literal (.).
  local ESCAPED_DIFF
  ESCAPED_DIFF=$(echo "$GIT_DIFF" | jq -R -s '.')

  # 3. Construct the JSON payload for the Gemini API
  local JSON_PAYLOAD
  JSON_PAYLOAD=$(
    cat <<EOF
{
  "contents": [
    {
      "parts": [
        { "text": "${PROMPT}" },
        { "text": "\n\nGit Diff:\n" },
        { "text": ${ESCAPED_DIFF} }
      ]
    }
  ],
  "generationConfig": {
    "temperature": 0.4,
    "topK": 32,
    "topP": 1,
    "maxOutputTokens": 150,
    "stopSequences": []
  },
  "safetySettings": [
    { "category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
    { "category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
    { "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
    { "category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" }
  ]
}
EOF
  )

  echo "🤖 Contacting Gemini to generate a commit message..."

  # 4. Call the Gemini API using curl
  local API_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$GEMINI_API_KEY"
  local RESPONSE
  RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "${JSON_PAYLOAD}" \
    "${API_URL}")

  # 5. Check for API errors in the response
  if echo "$RESPONSE" | jq -e '.error' >/dev/null; then
    echo "❌ Error calling the Gemini API."
    # Pretty-print the error JSON
    echo "$RESPONSE" | jq '.'
    return 1
  fi

  # 6. Parse the response to extract the generated text
  # - We target the first candidate's content part.
  # - 'tr -d '\n'` removes potential newlines.
  # - 'sed 's/^`*//;s/`*$//'` removes leading/trailing backticks.
  local COMMIT_MESSAGE
  COMMIT_MESSAGE=$(echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text' | tr -d '\n' | sed 's/^`*//;s/`*$//' | sed 's/commit: //')

  # --- Final Output ---

  if [ -z "$COMMIT_MESSAGE" ]; then
    echo "❌ Failed to generate a commit message. The API response might be empty or in an unexpected format."
    echo "Full API Response:"
    echo "$RESPONSE" | jq '.'
    return 1
  fi

  echo ""
  echo "🎉 Success! Here is your generated commit message:"
  echo ""
  echo -e "\033[1;32m   $COMMIT_MESSAGE\033[0m" # Print message in bold green
  echo ""
  echo "------------------------------------------------------------------"
  echo "To use this message, first stage your files, then commit:"
  echo -e "  \033[1mgit add .\033[0m"
  echo -e "  \033[1mgit commit -m \"$COMMIT_MESSAGE\"\033[0m"
  echo "------------------------------------------------------------------"
}

# This allows the script to be run directly or sourced.
# If the script is run directly, it will execute the function.
# If it's sourced, the function will be defined in the shell.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  ggc "$@"
fi
