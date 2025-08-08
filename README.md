# zsh-chatgpt

Terminal ChatGPT interface with session memory, streaming output and shell context injection.

## Features


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


## License

MIT

