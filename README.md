# teach-code

A Claude Code skill that teaches you **programming topics** (default stack: .NET / C#) over many sessions, using a persistent learning loop:

1. **Current knowledge**: what you know now
2. **Research and lesson**: one short, sourced lesson aimed at your next gap
3. **Assignment**: you apply the concept in code, with xUnit tests you run yourself
4. **Updated state**: progress is recorded in `STATE.md` and committed to git
5. Back to step 1

## One hub, many topics

You don't create a folder per topic. Make one folder (the *hub*), open Claude Code in it, and run `/teach-code <topic>`. The skill creates `<topic>/` itself.

```
learning/
├── INDEX.md       every topic, with its next step
├── NOTES.md       your preferences and .NET version, shared across topics
├── assets/        shared stylesheet and quiz component
├── dotnet/        MISSION, STATE, RESOURCES, GLOSSARY, lessons, assignments, learning-records, reference, project
└── nlp/
```

- `/teach-code dotnet` resumes `dotnet/`, or creates it.
- `/teach-code` with no topic resumes your only topic, or lists them all and asks which to continue.
- "Quick review" runs a review-only pass on what's due, with no new lesson.

## What's different from teach-loop

- Hub with auto-created topic folders and an `INDEX.md`.
- Coding only; assignments are xUnit projects scaffolded by `scripts/new-assignment.sh`, and review runs `dotnet test`, `dotnet build -warnaserror` and `dotnet format --verify-no-changes`.
- Onboarding script, SDK check, and a research step that requires fetched, cited sources and flags anything unverified.
- Starter stylesheet and quiz component, so every lesson looks the same and follows the quiz rules.
- Code-specific exercise types (predict, break it, read the trace, refactor, from memory, extend the capstone), a git history per topic, a review-only mode, and a check-in every fifth cycle.

## Install

Clone this repo and link it into your skills folder:

```bash
git clone https://github.com/Rhea-Thomas/teach-code.git ~/code/teach-code
ln -s ~/code/teach-code ~/.claude/skills/teach-code
```

Requires the [.NET SDK](https://dotnet.microsoft.com/download) for the code assignments.

## Credits

This project is derived from two MIT-licensed works:

- [`teach`](https://github.com/mattpocock/skills/tree/main/skills/productivity/teach) by **Matt Pocock**, the original skill.
- [`teach-loop`](https://github.com/polysius/teach-loop) by **polysius**, which added `STATE.md`, assignments and the learning loop.

teach-code adds the hub layout and a coding focus. Co-developed with Claude (Anthropic). See [LICENSE](./LICENSE); the original copyright notice must be kept in all copies.
