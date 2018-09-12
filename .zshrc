# Plugins
ANTIGEN_SOURCE=~/.antigen/antigen.zsh
if [ ! -e $ANTIGEN_SOURCE ]
then
    mkdir -p $(dirname $ANTIGEN_SOURCE)
    curl -L https://git.io/antigen > $ANTIGEN_SOURCE
fi
source $ANTIGEN_SOURCE
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search # after zsh-syntax-highlighting
antigen apply

# Plugin: zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=yes
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Prompt
PROMPT='%{$fg_bold[cyan]%}%~%{$reset_color%}$(git_prompt_info)
%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})$%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}%(?..$?)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}) %{$fg[yellow]%}○ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}) %{$fg[green]%}● "

# Color scheme
if [ -n "${COLORTERM:-}" -o "${TERM:-}" = xterm ]
then
    export TERM=xterm-256color

    # Molokai for Vim
    tput initc 0 106 114 118
    tput initc 1 976 149 447
    tput initc 2 651 886 180
    tput initc 3 957 749 459
    tput initc 4 400 851 937
    tput initc 5 682 506 1000
    tput initc 6 631 937 894
    tput initc 7 973 973 949
    tput initc 8 494 557 569
    tput initc 9 976 149 447
    tput initc 10 651 886 180
    tput initc 11 957 749 459
    tput initc 12 400 851 937
    tput initc 13 682 506 1000
    tput initc 14 631 937 894
    tput initc 15 973 973 949
fi

source ~/.aliases
source ~/.exports

if [ -e /usr/share/fzf/completion.zsh ]
then
    source /usr/share/fzf/completion.zsh
fi

if [ -e /usr/share/fzf/key-bindings.zsh ]
then
    source /usr/share/fzf/key-bindings.zsh
fi

if command -v helm
then
    source <$(helm completion zsh)
fi

if command -v kubectl
then
    source <$(kubectl completion zsh)
fi
