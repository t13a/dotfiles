export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"

[ -e /usr/bin/kubectl ] && source <(/usr/bin/kubectl completion bash)
