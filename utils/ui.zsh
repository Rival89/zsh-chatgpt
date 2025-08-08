# Utility functions for zsh-chatgpt

# Ensure necessary directories exist
ensure_dirs() {
  mkdir -p "$CHATGPT_SESSION_DIR" "$CHATGPT_LOG_DIR"
}

# Check that required commands exist
require_cmd() {
  for cmd in "$@"; do
    if ! command -v "$cmd" >/dev/null; then
      printf 'Required command not found: %s\n' "$cmd" >&2
      return 1
    fi
  done
}

# Warn about missing optional utilities that enhance UX
warn_optional_cmds() {
  [[ -n ${CHATGPT_SUPPRESS_WARN:-} ]] && return
  command -v gum >/dev/null || printf 'Optional command not found: gum (for nicer prompts)\n' >&2
  command -v fzf >/dev/null || printf 'Optional command not found: fzf (for session selection)\n' >&2
  if ! command -v glow >/dev/null && ! command -v bat >/dev/null; then
    printf 'Optional command not found: glow or bat (for markdown rendering)\n' >&2
  fi
}

# Fetch the last few commands from shell history and format them
get_shell_context() {
  local lines=${CHAT_SHELL_HISTORY_LINES:-20}
  fc -ln -$lines 2>/dev/null | sed 's/^/ - /'
}

# Allow the user to pick an existing session using fzf
select_session() {
  ensure_dirs
  local files=("$CHATGPT_SESSION_DIR"/*.json(N))
  if (( ${#files[@]} == 0 )); then
    echo "$CHATGPT_SESSION_DIR/$CHATGPT_DEFAULT_SESSION.json"
    return
  fi
  if command -v fzf >/dev/null; then
    local selected
    selected=$(printf "%s\n" "${files[@]##*/}" | fzf --prompt="Session> ")
    [[ -n $selected ]] && echo "$CHATGPT_SESSION_DIR/$selected" || echo "$CHATGPT_SESSION_DIR/$CHATGPT_DEFAULT_SESSION.json"
  else
    printf "%s\n" "${files[@]}"
  fi
}

# Render markdown using glow or bat if available
render_markdown() {
  local text="$1"
  if command -v glow >/dev/null; then
    printf "%s" "$text" | glow -
  elif command -v bat >/dev/null; then
    printf "%s" "$text" | bat -l markdown
  else
    printf "%s\n" "$text"
  fi
}

# Append a message to the session JSON file
append_message() {
  local role="$1" content="$2" file="$3"
  local tmpfile
  tmpfile=$(mktemp)
  [[ ! -f "$file" ]] && print '[]' > "$file"
  jq --arg role "$role" --arg content "$content" \
     '. + [{"role":$role,"content":$content}]' "$file" > "$tmpfile" \
     && mv "$tmpfile" "$file"
}

# Log a conversation turn to the log directory
log_turn() {
  local session="$1" user="$2" assistant="$3"
  local logfile="$CHATGPT_LOG_DIR/${session}_$(date +%Y%m%d).md"
  {
    printf "### %s\n\n" "$(date '+%Y-%m-%d %H:%M:%S')"
    printf "**You:** %s\n\n" "$user"
    printf "**ChatGPT:** %s\n\n" "$assistant"
  } >> "$logfile"
}

