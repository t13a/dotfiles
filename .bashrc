source ~/.aliases
source ~/.exports

if command -v helm
then
    source <$(helm completion bash)
fi

if command -v kubectl
then
    source <$(kubectl completion bash)
fi
