# INDEX.md Format

`INDEX.md` lives at the hub root. It is the table of contents for every topic, so a session with no argument can show where each one stands and ask which to continue. Update a topic's row at the end of every cycle (step 4 of the loop).

## Template

```md
# Learning Index

| Topic | Mission | Cycle | Next step | Last updated |
|---|---|---|---|---|
| [dotnet](./dotnet/STATE.md) | Ship a minimal API for my capstone | 3 | Assignment 0003 open: dependency injection | 2026-11-09 |
| [nlp](./nlp/STATE.md) | Add text classification with ML.NET | 1 | Lesson 0001: tokenisation | 2026-11-12 |
```

## Rules

- **One row per topic.** The link goes to that topic's `STATE.md`.
- **Mission in under ten words**, copied from `MISSION.md`'s "Why".
- **Next step is one phrase**, copied from `STATE.md`'s `## Now`. It's what the user sees when choosing what to resume.
- **Keep it a table, nothing else.** Detail belongs in the topic's files.
- **Don't delete finished topics**; mark the next step `Complete`.
