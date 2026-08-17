# macOS environment

Install the command-line tools, applications, FiraCode Nerd Font, Python
environment, Zsh plugins, and shell configuration:

```bash
git clone https://github.com/lhcavalcanti/environment.git
cd environment
./install.sh
```

The installer backs up existing `.zprofile` and `.zshrc` files before replacing
them. It is safe to run again; Homebrew skips packages that are already
installed.

After installation, open **iTerm2 > Settings > Profiles > Text** and select
**FiraCode Nerd Font Mono** for both fonts. Then restart the shell:

```bash
exec zsh -l
```

Authenticate tools separately with `gh auth login`, `az login`, `copilot`, and
`claude`.
