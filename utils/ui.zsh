# Utility functions for zsh-chatgpt

ensure_session_dir() {
  # Ensure the directory for the session file exists
  local dir
  dir=$(dirname "$CHAT_SESSION_FILE")
  mkdir -p "$dir"
}

get_shell_context() {
  # Get the last few shell history lines and format as bullet points
  local lines=${CHAT_SHELL_HISTORY_LINES:-5}
  history | tail -n "$lines" | sed 's/^/ - /'
}

select_session() {
  # Present available session files and let user pick one via fzf
  local dir
  dir=$(dirname "$CHAT_SESSION_FILE")
  local files
  files=("$dir"/*.json(N))
  [[ ${#files[@]} -eq 0 ]] && echo "$CHAT_SESSION_FILE" && return
  local selected
  selected=$(printf "%s\n" "${files[@]##*/}" | fzf --prompt="Select session: ")
  echo "$dir/$selected"
}

append_to_session() {
  # Append assistant message to the current session JSON file
  local content="$1"
  local file="${CHAT_SESSION_FILE}"
  local tmpfile
  tmpfile=$(mktemp)
  if [[ ! -f "$file" ]]; then
    echo '[]' > "$file"
  fi
  jq --arg content "$content" '. + [{"role":"assistant","content":$content}]' "$file" > "$tmpfile" && mv "$tmpfile" "$file"
}
