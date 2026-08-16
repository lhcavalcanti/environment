# Shell setup (zsh)

## Install base tools

```bash
brew install git neovim starship eza bat fd fzf
brew install --cask iterm2
brew install --cask copilot-cli
brew install --cask claude-code
```

Verify the AI CLIs:

```bash
copilot --version
claude --version
```

Start `copilot` and run `/login` if prompted. Start `claude` and follow its browser authentication flow.

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

## Configure `~/.zshrc`

Use this layout:

```bash
# ---- Prompt ----
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# ---- Path / environment ----
export CAPMAN_DIR="$HOME/src/LLMApi/sources/scripts/CapMan"
export LLMLAB_OUTPUT_DIR="$HOME/src/lcavalcanti/artifacts"

# BEGIN Agency MANAGED BLOCK
if [[ ":${PATH}:" != *":/Users/lcavalcanti/.config/agency/CurrentVersion:"* ]]; then
    export PATH="/Users/lcavalcanti/.config/agency/CurrentVersion:${PATH}"
fi
# END Agency MANAGED BLOCK

# BEGIN claude-cli MANAGED BLOCK
if [[ ":${PATH}:" != *":/Users/lcavalcanti/.claude-cli/CurrentVersion:"* ]]; then
    export PATH="/Users/lcavalcanti/.claude-cli/CurrentVersion:${PATH}"
fi
# END claude-cli MANAGED BLOCK

. "$HOME/.local/bin/env"
source ~/.venvs/default/bin/activate

# ---- Oh My Zsh custom plugin path ----
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# ---- Zsh plugins ----
if [ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "$ZSH_CUSTOM/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# zsh-syntax-highlighting should be sourced after other plugins.
if [ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ---- Key bindings ----
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ---- FZF + FD + BAT ----
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d'

export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --preview "bat --style=numbers --color=always --line-range :200 {}"
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---- Aliases ----
alias pilot='cd /Users/lcavalcanti/src/lcavalcanti && copilot --add-dir /Users/lcavalcanti/.copilot/installed-plugins/llmapi/llmlab --add-dir /Users/lcavalcanti/src --add-dir /Users/lcavalcanti/code --add-dir /Users/lcavalcanti/code/export-model-runner'
alias start-cc2='/Users/lcavalcanti/src/lcavalcanti/tools/scripts/cc2-devtunnel.sh'
alias stop-cc2='/Users/lcavalcanti/src/lcavalcanti/tools/scripts/stop-cc2-devtunnel.sh'
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias la='eza -la --icons'
alias cat='bat'
alias findf='fd'
alias f='fzf'
alias vf='nvim $(fzf)'  # fuzzy open file in nvim
alias cf='cd $(fd --type d | fzf)'  # fuzzy cd into dir
alias please='sudo'
alias ..='cd ..'
```

## Standard tool replacements

| Standard tool  | Replacement | Alias            |
| -------------- | ----------- | ---------------- |
| `ls`           | `eza`       | `ls`, `ll`, `la` |
| `cat`          | `bat`       | `cat`            |
| `find`         | `fd`        | `findf`          |
| `grep` (fuzzy) | `fzf`       | `f`              |

Reload shell:

```bash
source ~/.zshrc
```
