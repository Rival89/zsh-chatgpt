#!/usr/bin/env bats

setup() {
  export CHATGPT_SESSION_DIR="$BATS_TEST_TMPDIR/sessions"
  export CHATGPT_LOG_DIR="$BATS_TEST_TMPDIR/logs"
  mkdir -p "$CHATGPT_SESSION_DIR" "$CHATGPT_LOG_DIR"
  export OPENAI_API_KEY=test
  export CHATGPT_SUPPRESS_WARN=1
}

@test "creates new session" {
  run ./bin/chatgpt --new-session foo --list
  [ "$status" -eq 0 ]
  [ -f "$CHATGPT_SESSION_DIR/foo.json" ]
}

@test "lists sessions" {
  touch "$CHATGPT_SESSION_DIR/bar.json"
  run ./bin/chatgpt --list
  [ "$status" -eq 0 ]
  [[ "$output" == *"bar"* ]]
}

@test "clears session" {
  echo '[{"role":"user","content":"hi"}]' > "$CHATGPT_SESSION_DIR/clear.json"
  run ./bin/chatgpt --session clear --clear
  [ "$status" -eq 0 ]
  [ ! -s "$CHATGPT_SESSION_DIR/clear.json" ]
}

