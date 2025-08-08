get_api_key() {
  local key_file="$HOME/.config/zsh-chatgpt/api_key"

  # Allow overriding via existing environment variable
  if [[ -n ${OPENAI_API_KEY:-} ]]; then
    return
  fi

  if [[ ! -f "$key_file" ]]; then
    mkdir -p "${key_file:h}"
    local newkey
    if command -v gum >/dev/null; then
      newkey=$(gum input --password --prompt="Enter your OpenAI API key: ")
    else
      printf "Enter your OpenAI API key: "
      read -r newkey
    fi
    print -- "$newkey" > "$key_file"
    chmod 600 "$key_file"
  fi
  export OPENAI_API_KEY=$(<"$key_file")
}
