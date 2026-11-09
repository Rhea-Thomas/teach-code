# Assignment Format

Assignments live in `./assignments/` and take the number and slug of the lesson they apply: lesson `0003-binary-search.html` gets assignment `0003-binary-search.md`. Create the directory lazily: only when the first assignment is written. Code goes in a matching folder, `./assignments/0003-binary-search/`.

An assignment is step 3 of the learning loop. The lesson builds fluency; the assignment is where the user applies the concept and produces the evidence that updates `STATE.md`.

## Template

```md
# Assignment {NNNN}: {Title}

Applies [Lesson {NNNN}: {title}](../lessons/{NNNN}-{slug}.html). Gap: {the gap, as worded in STATE.md}.

## Warm-up
{Optional. One or two questions on concepts due for review in STATE.md, answered from memory before starting the task.}

## Task
{What to do, in one to five steps. A real or realistic task from the mission that needs the concept, a little beyond the lesson's worked examples.}

## Done when
- {A success criterion you can check from the submission}
- {…}

## Check your work
{The one command that runs the tests, e.g. `dotnet test assignments/{NNNN}-{slug}`. Run it as often as you like before submitting.}

## How to submit
{Where the work goes: the Submission section below, the matching folder, or a reply in chat. Then tell the agent it's done.}

## Submission
{Left blank for the user.}

## Feedback
{Written by the agent at each review: which criteria were met or missed, and specifically why. End with the outcome: `passed`, `needs revision` or `moved on`. On a revision, add the next attempt below the last instead of overwriting it.}
```

## Rules

- **Apply, don't recite.** The task must use the concept in a new situation. Recall questions belong in the lesson's quiz or the warm-up.
- **One gap only.** Apart from the warm-up, the assignment tests its lesson's gap and nothing else, so its outcome tells `STATE.md` exactly what was learned.
- **Finishable in one sitting.** A single tangible win, like the lesson. Not a project.
- **Checkable criteria.** Every "Done when" line must be verifiable from what the user submits. If you couldn't check it, rewrite it.
- **Coding assignments ship with tests.** Put a starter file and a test file in the matching folder, and the command that runs them under "Check your work". Test the "Done when" criteria as behaviour, not implementation, so the tests check the work without giving the solution away. Use xUnit, the default of `dotnet new xunit`, scaffolded by `scripts/new-assignment.sh`; for other languages use the built-in runner. Run the tests once before handing over: they should fail because the work isn't done, not because the setup is broken. At review, follow the review checklist in SKILL.md: tests, then `dotnet build -warnaserror` and `dotnet format --verify-no-changes`, then read the code.
- **Hints, not answers.** When the user is stuck, point to the part of the lesson or reference document that helps. Never hand over the solution: the effort is what builds storage strength.
- **Concept-only tasks report back.** For a design or architecture question with no code, the submission is a written answer judged against the criteria.
- **Submit their way.** If the user prefers replying in chat to editing the file (or the reverse), note it in `NOTES.md` and use it every time.
