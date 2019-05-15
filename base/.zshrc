source "${HOME}/.zplug/init.zsh"
zplug "lib/clipbord", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh, defer:2 # after lib/keybindings
zplug "plugins/git-prompt", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2 # after zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:2 # after zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting"
zplug check || zplug install
zplug load

# zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=yes

source ~/.aliases
source ~/.exports
source ~/.key-bindings
source ~/.zsh-theme
