# oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
if [ ! -e "${ZSH}/oh-my-zsh.sh" ]
then
    git clone \
    --depth 1 \
    https://github.com/robbyrussell/oh-my-zsh.git \
    "${ZSH}"
fi
plugins=(
    fzf
    git-prompt
    z
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions # after zsh-syntax-highlighting
    zsh-users/zsh-history-substring-search # after zsh-syntax-highlighting
)
for index in $(seq 1 ${#plugins[@]})
do
    plugin="${plugins[${index}]}"
    if [ "${plugin}" != "${plugin##*/}" ]
    then
        plugins[${index}]="${plugin##*/}"
        if [ ! -d "${ZSH}/custom/plugins/${plugin##*/}" ]
        then
            git clone \
            --depth 1 \
            "https://github.com/${plugin}" \
            "${ZSH}/custom/plugins/${plugin##*/}"
        fi
    fi
done
unset index
unset plugin
source "${ZSH}/oh-my-zsh.sh"

# zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=yes

# Prompt
PROMPT='%{$fg_bold[black]%}%~%{$reset_color%} $(git_super_status)
%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})$%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}%(?..$?)%{$reset_color%}'

# Color scheme
if [ -n "${COLORTERM:-}" -o "${TERM:-}" = xterm ]
then
    export TERM=xterm-256color

    # Molokai for Vim
    if which tput > /dev/null
    then
        # tput initc 0 106 114 118
        tput initc 0 494 557 569
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
fi

source ~/.aliases
source ~/.key-bindings
source ~/.exports
