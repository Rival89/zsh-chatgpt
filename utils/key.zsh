get_api_key() {
  local key_file="$HOME/.config/zsh-chatgpt/api_key"
  if [[ ! -f "$key_file" ]]; then
    mkdir -p "$(dirname "$key_file")"
    local newkey=$(gum input --password --prompt="Enter your OpenAI API Key: ")
    echo "$newkey" > "$key_file"
    chmod 600 "$key_file"
  fi
  export OPENAI_API_KEY=$(<"$key_file")
}
