# Load configuration and path setup
source "${0:A:h}/config/config.zsh"
fpath=(${0:A:h}/bin $fpath)
autoload -Uz chatgpt
