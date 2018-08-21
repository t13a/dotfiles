source ~/.{aliases,exports}

command -v helm && source <(helm completion bash)
command -v kubectl && source <(kubectl completion bash)
