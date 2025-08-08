# Entry point for zsh-chatgpt plugin

source "${0:A:h}/config/config.zsh"

# Add bundled scripts to PATH
path=(${0:A:h}/bin $path)

# Enable completion
fpath=(${0:A:h}/completions $fpath)
autoload -Uz _chatgpt
compdef _chatgpt chatgpt

