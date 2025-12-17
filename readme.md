# PoshPrompt

PowerShell CLI input prompt library heavily inspired by [github.com/bombshell-dev/clack](https://github.com/bombshell-dev/clack).

---

## Roadmap

- [ ] Make the function verbs more consistent
- [ ] Conform with the standard Get-Verb list (Render-... is not valid)
- [ ] Allow `Ctrl+C` have the same exit behavior as `Esc` key.
- [ ] Add docstrings to all public functions
- [ ] Introduce a module prefix (ex: `<Verb>-Prompt<FunctionName>` => `Invoke-PromptIntro` or `Invoke-PromptConfirm`)

**New prompts/macros:**

- [ ] Multiselect prompt
- [ ] Password prompt
- [ ] Logs (simple, styled text); Variants = info, success, step, warn, error, default
- [ ] Tasks (execute multiple tasks with spinners)
- [ ] TaskLog (render output logs continuously and clear output if task completes successfully)
- [ ] Note (multiline text)
- [ ] Progress bar
