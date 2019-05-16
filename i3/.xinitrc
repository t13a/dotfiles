#!/bin/bash

set -euo pipefail

[ -f ~/.xprofile ] && source ~/.xprofile
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xkbmap ] && setxkbmap "$(cat ~/.Xkbmap)"

exec awesome
