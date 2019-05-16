source "${HOME}/.zplug/init.zsh"
zplug "lib/*", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh, defer:2 # after lib/*
zplug "plugins/git-prompt", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2 # after zsh-syntax-highlighting
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:2 # after zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting"
[[ $- =~ i ]] || zplug check --verbose || zplug install
zplug load

# git-prompt
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{!%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{+%G%}"

# zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=yes

source ~/.aliases
source ~/.exports
source ~/.key-bindings
source ~/.zsh-theme
