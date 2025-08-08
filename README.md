# zsh-chatgpt

Terminal ChatGPT interface with session memory, streaming output and shell context injection.

## Features

- Uses the official OpenAI API with streaming responses
- Multiple models (`-m gpt-4o`, `-m o3`, ...)
- Session management: `--session`, `--new-session`, `--list`, `--clear`
- Automatically injects recent shell history into each prompt
- Optional TUI helpers via `fzf` and `gum`
- Markdown rendering through `glow` or `bat`
- `--markdown` flag renders responses via `glow` or `bat`
- Image generation with `--image`
- Logs every conversation to `~/.chatgpt_logs/`
- API key stored securely in `~/.config/zsh-chatgpt/api_key`
- Config overrides via `~/.config/zsh-chatgpt/config.zsh`
- Retries transient network errors by default

## Installation

```zsh
# with git
git clone https://github.com/youruser/zsh-chatgpt ~/.zsh-chatgpt
echo "source ~/.zsh-chatgpt/chatgpt.plugin.zsh" >> ~/.zshrc

# or using zinit
zinit light youruser/zsh-chatgpt
```

On first run the plugin prompts for your OpenAI API key and stores it with `chmod 600`.

## Usage

Start an interactive session:

```bash
chatgpt
```

Ask a single question:

```bash
chatgpt "Write a haiku about shells"
```

Switch or create sessions:

```bash
chatgpt --session work
chatgpt --new-session demo
```

Generate an image:

```bash
chatgpt --image "A cat hacking on a laptop"
```

List or clear sessions:

```bash
chatgpt --list
chatgpt --clear
```

Additional context flags:

- `--file path/to/file` – include file contents
- `--cmd "ls -al"` – include command output
- `--pipe` – read extra context from STDIN
- `--markdown` – render final response with glow or bat

Logs are written to `~/.chatgpt_logs/SESSION_YYYYMMDD.md`.

Optional settings can be placed in `~/.config/zsh-chatgpt/config.zsh`, e.g.:

```zsh
OPENAI_MODEL=o3
CHAT_SHELL_HISTORY_LINES=50
```

## Dependencies

`curl`, `jq` and optionally `fzf`, `gum`, `glow` or `bat` for enhanced UI. Missing optional tools are warned at runtime.

## License

MIT

