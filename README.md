# .kissh - Keep It Simple, Stupid.sh

.kissh is a simple, opinionated, and lightweight framework for your Bash environment. It's for those who want a faster, more organized shell without the bloat of larger frameworks. It provides a solid foundation for your Bash configuration, not a mountain of features you'll never use.

## What is .kissh?

This isn't another "Oh My" framework with hundreds of plugins and themes. .kissh is an architectural pattern for your `~/.bashrc`. It gives you a clean structure to organize your aliases, functions, and visual tweaks while keeping startup times fast and your configuration files readable.

It is opinionated. It makes choices for you based on what is considered modern best practice, such as using `PROMPT_COMMAND` for prompt rendering. The goal is to give you a powerful, beautiful, and robust setup right out of the box with minimal fiddling.

## Features

- **Simple by Design**: A minimal core that's easy to understand and extend. No magic.
- **Fast Startup**: No noticeable lag when opening a new terminal.
- **Modular Structure**: A clean `~/.kissh` directory to organize your shell customizations into logical `plugins` and `themes`.
- **Sensible Defaults**: Comes with a pre-configured, visually pleasing default theme.
- **Easy Customization**: Designed to be forked, tweaked, and made your own.

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/dothash/kissh.git ~/.kissh
    ```

2. **Source it from your `.bashrc`:** Add the following lines to the end of your `~/.bashrc` file.

    ```bash
    # Load .kissh - Keep It Simple, Stupid.sh
    export KISSH_THEME="dothash" # or "fancy", "simple"
    if [ -f ~/.kissh/kissh.sh ]; then
      source ~/.kissh/kissh.sh
    fi
    ```

3. **Reload your shell:**

    ```bash
    source ~/.bashrc
    ```

    Or simply open a new terminal window.

## Usage

The framework is structured into several directories to keep your environment organized:

-   **`aliases/`**: Holds all your alias definitions. Each `.sh` file in this directory is sourced automatically. You can group your aliases by topic (e.g., `git.sh`, `docker.sh`).
-   **`functions/`**: Similar to aliases, this is for your shell functions. Each `.sh` file is sourced.
-   **`plugins/`**: For more complex scripts or configurations. These are `*.plugin.sh` files that can set environment variables, configure tools, or do anything more involved than a simple alias or function.
-   **`themes/`**: Contains different prompt themes. You can switch between them by setting the `KISSH_THEME` variable in your `.bashrc`.

## How It Works

The core of `.kissh` is the main `kissh.sh` file, which acts as a loader. On startup, it does the following:

1.  Sources all `*.plugin.sh` files from `~/.kissh/plugins/`.
2.  Sources all `*.sh` files from `~/.kissh/aliases/`.
3.  Sources all `*.sh` files from `~/.kissh/functions/`.
4.  Loads the theme specified by the `$KISSH_THEME` environment variable from the `~/.kissh/themes/` directory.

The structure looks like this:

```
~/.kissh/
├── kissh.sh              # The main script that loads everything
├── aliases/              # All your shell aliases
│   ├── git.sh
│   └── kubectl.sh
├── functions/            # All your shell functions
│   ├── git.sh
│   └── kubectl.sh
├── plugins/              # Scripts for configuration and setup
│   ├── colors.plugin.sh
│   └── fzf.plugin.sh
└── themes/               # Prompt themes
    ├── dothash.theme.sh
    └── clean.theme.sh
```

Files in `aliases`, `functions`, and `plugins` are loaded in alphabetical order.

## Customization

Making `.kissh` your own is simple.

### Adding Your Own Aliases

1.  Create a new file in the `~/.kissh/aliases/` directory (e.g., `personal.sh`).
2.  Add your aliases to this file.

**Example: `~/.kissh/aliases/personal.sh`**

```bash
# Personal Aliases
alias ls='eza --icons'
alias c='clear'
alias ..='cd ..'
```

### Adding Your Own Functions

1.  Create a new file in the `~/.kissh/functions/` directory (e.g., `utils.sh`).
2.  Add your functions to this file.

**Example: `~/.kissh/functions/utils.sh`**

```bash
# Greeting function
function hello() {
  echo "Hello, $(whoami)!"
}
```

### Adding a Plugin

If you need to set environment variables or run setup scripts, a plugin is the right place.

1.  Create a file ending in `.plugin.sh` in the `~/.kissh/plugins/` directory.
2.  Add your script logic.

**Example: `~/.kissh/plugins/node.plugin.sh`**

```bash
# Add ~/.local/bin to the PATH
export PATH="$HOME/.local/bin:$PATH"

# Setup NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### Customizing the Theme

You can edit any of the existing themes in the `~/.kissh/themes/` directory. The active theme is determined by the `$KISSH_THEME` variable in your `.bashrc`.

To create a new theme:

1.  Copy an existing theme file to a new name, e.g., `cp ~/.kissh/themes/clean.theme.sh ~/.kissh/themes/mytheme.theme.sh`.
2.  Customize `~/.kissh/themes/mytheme.theme.sh` to your liking.
3.  Change `export KISSH_THEME="mytheme"` in your `.bashrc`.

## Philosophy

The "Keep It Simple, Stupid" principle is the guiding force behind this project.

- **Readability over Abstraction**: You should be able to read the source code of your shell framework and understand what it's doing.
- **You're in Control**: .kissh provides a structure, not a cage. There are no complex update scripts or hidden behaviors. Your `~/.kissh` directory is yours to manage as you see fit.
- **Opinionated means Strong Defaults**: The default configuration is not meant to be a neutral starting point, but a fully usable and powerful environment from the very first launch.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
