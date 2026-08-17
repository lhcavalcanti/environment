#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer supports macOS only." >&2
  exit 1
fi

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew install git gh azure-cli node uv neovim starship eza bat fd fzf
brew install --cask \
  iterm2 \
  font-fira-code-nerd-font \
  copilot-cli \
  claude-code

uv python install 3.14
mkdir -p "$HOME/.venvs"
if [[ ! -d "$HOME/.venvs/default" ]]; then
  uv venv --python 3.14 "$HOME/.venvs/default"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$zsh_custom/plugins"

install_plugin() {
  local name="$1"
  local url="$2"
  local destination="$zsh_custom/plugins/$name"

  if [[ ! -d "$destination/.git" ]]; then
    git clone --depth 1 "$url" "$destination"
  fi
}

install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
install_plugin zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search
install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

timestamp="$(date +%Y%m%d-%H%M%S)"
for file in .zprofile .zshrc; do
  if [[ -e "$HOME/$file" ]]; then
    cp -R "$HOME/$file" "$HOME/$file.$timestamp.bak"
  fi
done

mkdir -p "$HOME/.config"
install -m 0644 "$repo_dir/config/zprofile" "$HOME/.zprofile"
install -m 0644 "$repo_dir/config/zshrc" "$HOME/.zshrc"
install -m 0644 "$repo_dir/config/starship.toml" "$HOME/.config/starship.toml"

echo
echo "Setup complete. Select 'FiraCode Nerd Font Mono' in iTerm2, then run: exec zsh -l"
