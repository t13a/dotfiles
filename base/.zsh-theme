PROMPT='%{$fg_bold[black]%}%~%{$reset_color%} $(git_super_status)
%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})$%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}%(?..$?)%{$reset_color%}'

if [ -n "${COLORTERM:-}" -o "${TERM:-}" = xterm ]
then
    export TERM=xterm-256color

    # Molokai for Vim
    if command -v tput > /dev/null
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
