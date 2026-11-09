# STATE.md Format

`STATE.md` lives at the root of the topic folder (`<hub>/<topic>/STATE.md`). It is the persistent memory of the learning loop: what the user knows now, which gaps come next, where they are in the current cycle, and how they got here. Read it first in every session and rewrite it at the end of every step. A new session with no other context must be able to resume from it alone.

## Template

```md
# Learning State: {Topic}

Cycle {N}, last updated {YYYY-MM-DD}

## Now
- **Step**: {where to resume: 1 Current knowledge | 2 Lesson | 3 Assignment | 4 Updated State}
- **Lesson**: [{NNNN} {title}](./lessons/{NNNN}-{slug}.html), or none
- **Assignment**: [{NNNN} {title}](./assignments/{NNNN}-{slug}.md), {assigned | needs revision | passed | moved on}, or none
- **Next**: {One sentence: exactly what to do when the next session starts.}

## Current knowledge
- {Something the user can now do, phrased as a skill} ([LR-0004](./learning-records/0004-{slug}.md))
- {…}

## Gaps
1. **{The next gap}**: {why it's next, from the mission or the last assignment}
2. {…}

## Due for review
- {Concept} ([LR-0002](./learning-records/0002-{slug}.md)): due {YYYY-MM-DD}, interval {N} days

## Progress log
| Cycle | Date | Gap | Lesson | Assignment | Outcome |
|---|---|---|---|---|---|
| 1 | {YYYY-MM-DD} | {gap} | [0001](./lessons/0001-{slug}.html) | [0001](./assignments/0001-{slug}.md) | {passed or moved on} |
```

## Rules

- **Write after every step, not just step 4.** A session can end at any time, so `## Now` must always match what has actually happened.
- **Evidence, not coverage.** A skill enters "Current knowledge" only when a learning record backs it (an assignment passed, a diagnostic answered, prior knowledge stated), and each bullet links to its record. When a record is superseded, update or remove its bullet.
- **The top gap is the next lesson.** Re-rank `## Gaps` in step 1 of every cycle. Remove gaps that are closed; add any an assignment revealed or the user left open by moving on.
- **Space the reviews.** Schedule a newly learned concept for review a few days out. A successful recall roughly doubles its interval; a miss resets it to a day or two. Reviews that are due become the next assignment's warm-up.
- **One log row per cycle.** The log shows the progression at a glance; the detail lives in the files it links to. Once it passes about fifteen rows, fold the oldest into one summary line.
- **Keep it short.** It is read at the start of every session. If it runs past a couple of screens, it is duplicating the learning records.
