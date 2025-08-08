# Configuration for zsh-chatgpt

# Load API key securely. The key is stored in
#   ~/.config/zsh-chatgpt/api_key
# and retrieved via utils/key.zsh. This file must exist
# with permissions 600. Users will be prompted for the key
# the first time the plugin runs.

source "${0:a:h}/../utils/key.zsh"
get_api_key

# ----- Default configuration -----

# Default chat model. Can be overridden via the -m/--model flag.
: ${OPENAI_MODEL:=gpt-4o}

# Default image model used by --image flag.
: ${OPENAI_IMAGE_MODEL:=gpt-image-1}

# API endpoints
: ${OPENAI_API_URL:=https://api.openai.com/v1/chat/completions}
: ${OPENAI_IMAGE_URL:=https://api.openai.com/v1/images/generations}

# Where session JSON files and logs are stored
: ${CHATGPT_SESSION_DIR:="$HOME/.chatgpt_sessions"}
: ${CHATGPT_LOG_DIR:="$HOME/.chatgpt_logs"}

# Name of the default session when none is specified
: ${CHATGPT_DEFAULT_SESSION:=default}

# Number of previous shell commands to include as context
: ${CHAT_SHELL_HISTORY_LINES:=20}

# Retry behaviour for API requests
: ${CHATGPT_RETRY_MAX:=3}
: ${CHATGPT_RETRY_SLEEP:=2}

# Allow user overrides via ~/.config/zsh-chatgpt/config.zsh
user_cfg="$HOME/.config/zsh-chatgpt/config.zsh"
if [[ -f $user_cfg ]]; then
  source "$user_cfg"
fi

