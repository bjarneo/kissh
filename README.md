# .kissh

**Keep It Simple, Stupid.sh**

A simple, opinionated, and lightweight framework for your Bash environment. .kissh provides a clean structure to organize your aliases, functions, and plugins without the bloat of larger frameworks. It's for those who want a faster, more organized shell that's easy to understand and maintain.

The core philosophy is **readability over abstraction**. You should be able to read the source code of your shell framework and know exactly what it's doing.

## Features

- **Fast Startup**: No noticeable lag when opening a new terminal.
- **Modular by Design**: A clean `~/.kissh` directory to organize your shell customizations.
- **Simple Structure**: Separate directories for aliases, functions, plugins, and themes.
- **Easy to Customize**: Designed to be forked, tweaked, and made your own.
- **Sensible Defaults**: A powerful and visually pleasing setup out of the box.

## Prerequisites

While `.kissh` is lightweight and has no mandatory dependencies, some of the included aliases and functions are designed to work with other popular command-line tools. To get the most out of the default configuration, consider installing the following:

- **`git`**: For version control. Essential for the `git` aliases and functions.
- **`docker`**: For container management. Powers the `docker` aliases and functions.
- **`kubectl`**: For interacting with Kubernetes clusters. Used by the `kubectl` aliases and functions.
- **`eza`**: A modern replacement for `ls`. The `ls` alias is mapped to `eza`.

These tools are **optional**. If you don't have them installed, the corresponding aliases and functions will simply not work, but the rest of the framework will be unaffected.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/dothash/kissh.git ~/.kissh
   ```

2. **Source it from your `.bashrc`:** Add the following lines to the end of your `~/.bashrc` file.

   ```bash
   # Load .kissh - Keep It Simple, Stupid.sh
   # Set the theme you want to use. Themes are in ~/.kissh/themes/
   export KISSH_THEME="dothash"
   if [ -f ~/.kissh/kissh.sh ]; then
     source ~/.kissh/kissh.sh
   fi
   ```

3. **Reload your shell:**

   ```bash
   source ~/.bashrc
   ```

   Or simply open a new terminal window.

## How It Works

The main `kissh.sh` script acts as a loader. On startup, it sources files from the `~/.kissh` directory in the following order:

1. **Plugins**: All `*.plugin.sh` files in `~/.kissh/plugins/`.
2. **Aliases**: All `*.sh` files in `~/.kissh/aliases/`.
3. **Functions**: All `*.sh` files in `~/.kissh/functions/`.
4. **Theme**: The theme specified by `$KISSH_THEME` from `~/.kissh/themes/`.

Files in each directory are loaded in alphabetical order.

```
~/.kissh/
├── kissh.sh              # The main script that loads everything
├── aliases/              # Shell aliases (*.sh)
├── functions/            # Shell functions (*.sh)
├── plugins/              # Setup scripts & configurations (*.plugin.sh)
└── themes/               # Prompt themes (*.theme.sh)
```

## Customization

Making `.kissh` your own is straightforward. Just add files to the appropriate directories.

### Aliases

Create any `.sh` file in `~/.kissh/aliases/`.

**Example: `~/.kissh/aliases/common.sh`**

```bash
alias ls='eza --icons' # Requires eza
alias ll='eza --icons -l'
alias c='clear'
alias ..='cd ..'
```

### Functions

Create any `.sh` file in `~/.kissh/functions/`.

**Example: `~/.kissh/functions/utils.sh`**

```bash
# A simple greeting
function hello() {
  echo "Hello, $(whoami)!"
}

# Create a directory and cd into it
function mkcd() {
  mkdir -p "$1" && cd "$1"
}
```

### Plugins

Plugins are for more complex logic, like setting environment variables or configuring tools. Create any `*.plugin.sh` file in `~/.kissh/plugins/`.

**Example: `~/.kissh/plugins/node.plugin.sh`**

```bash
# Add local binaries to the PATH
export PATH="$HOME/.local/bin:$PATH"

# Setup NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi
```

### Themes

The active theme is determined by the `$KISSH_THEME` variable in your `.bashrc`. To create a new theme:

1. Copy an existing theme from `~/.kissh/themes/` to a new file (e.g., `mytheme.theme.sh`).
2. Customize the new file to your liking. It's just a shell script that sets the `PS1` variable and related functions.
3. Update the `export KISSH_THEME="mytheme"` line in your `.bashrc`.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
