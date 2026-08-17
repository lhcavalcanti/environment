# Shell setup (zsh)

## Install base tools

```bash
brew install git gh azure-cli node uv neovim starship eza bat fd fzf
brew install --cask iterm2
brew install --cask font-fira-code-nerd-font
brew install --cask copilot-cli
brew install --cask claude-code
```

Verify the development and AI CLIs:

```bash
gh --version
az version
node --version
npm --version
uv --version
copilot --version
claude --version
```

Run `gh auth login` and `az login`. Start `copilot` and run `/login` if prompted. Start `claude` and follow its browser authentication flow.

## Create the default Python environment

```bash
uv python install 3.14
mkdir -p "$HOME/.venvs"
uv venv --python 3.14 "$HOME/.venvs/default"
```

## Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install zsh plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Install the shell configuration

From the extracted archive directory, back up any existing shell files and install the supplied portable configuration:

```bash
timestamp="$(date +%Y%m%d-%H%M%S)"
[ -f "$HOME/.zprofile" ] && cp "$HOME/.zprofile" "$HOME/.zprofile.$timestamp.bak"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.$timestamp.bak"
mkdir -p "$HOME/.config"
install -m 0644 config/zprofile "$HOME/.zprofile"
install -m 0644 config/zshrc "$HOME/.zshrc"
install -m 0644 config/starship.toml "$HOME/.config/starship.toml"
```

## Standard tool replacements

| Standard tool  | Replacement | Alias            |
| -------------- | ----------- | ---------------- |
| `ls`           | `eza`       | `ls`, `ll`, `la` |
| `cat`          | `bat`       | `cat`            |
| `find`         | `fd`        | `findf`          |
| `grep` (fuzzy) | `fzf`       | `f`              |

Start a new login shell:

```bash
exec zsh -l
```

## Configure iTerm2 icons

In **iTerm2 > Settings > Profiles > Text**, set both **Font** and
**Non-ASCII Font** to **FiraCode Nerd Font Mono**, size 14. Restart iTerm2
after changing the profile so Starship and `eza` icons use the patched glyphs.
