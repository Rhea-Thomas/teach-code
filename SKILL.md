---
name: teach-code
description: Teach the user a programming topic (default stack .NET / C#) through a persistent learning loop (current knowledge, lesson, assignment, updated state) that resumes across sessions. Run it from a single learning hub; each topic gets its own subfolder, created automatically.
disable-model-invocation: true
argument-hint: "Topic to learn, e.g. dotnet, nlp (leave blank to resume)"
---

The user has asked you to teach them a programming topic. This is a stateful request: they will learn over many sessions. Progress persists in each topic's `STATE.md`, and every session follows [the learning loop](#the-learning-loop).

This skill is for **coding topics only**. If the user asks for something non-technical, say so and stop.

## The Hub and Topics

The directory the skill is run in is the **hub**. The user never creates topic folders; you do.

```
hub/
├── INDEX.md        all topics: status, next step (format: INDEX-FORMAT.md)
├── NOTES.md        the user's preferences and environment, shared by all topics
├── assets/         shared stylesheet and components, copied from assets-starter/ on first use
└── <topic>/        one folder per topic, e.g. dotnet/, nlp/
    ├── MISSION.md  STATE.md  RESOURCES.md  GLOSSARY.md
    ├── lessons/  assignments/  learning-records/  reference/
    └── project/    the evolving capstone repo, if the mission has one
```

Resolving the topic:

- **Argument given** (`/teach-code dotnet`): slugify it (lowercase, dashes). If `<topic>/` exists, resume it. If not, create it and run [onboarding](#onboarding).
- **No argument, `INDEX.md` missing**: ask what they want to learn, then as above.
- **No argument, one topic**: resume it.
- **No argument, several topics**: show each topic's one-line next step from `INDEX.md` and ask which to continue.
- **A new topic that overlaps an existing one** (NLP in .NET, say): create it, and read the existing topic's learning records so you never re-teach what is already known. Link to them from the new topic's records.

All workspace paths below (`./lessons/`, `STATE.md` and so on) are relative to the **topic folder**, except `NOTES.md`, `INDEX.md` and `assets/`, which live in the hub. Only the `*-FORMAT.md` links resolve from this skill's folder. Run `git init` in a topic folder when you create it, and commit after every step of the loop so each submission and review is a diff.

Topic files, each with a format in this skill's folder:

- `MISSION.md`: why the user is learning this ([MISSION-FORMAT.md](./MISSION-FORMAT.md)).
- `STATE.md`: what they know, ranked gaps, where they are in the loop, a progress log. The first file read each session ([STATE-FORMAT.md](./STATE-FORMAT.md)).
- `RESOURCES.md`: trusted sources ([RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md)).
- `GLOSSARY.md`: the topic's canonical terms ([GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md)). Once a term is in it, use it in every lesson.
- `learning-records/*.md`: evidence-backed notes on what the user learned ([LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md)).
- `lessons/*.html`: one tightly scoped lesson each, `0001-<dash-case>.html`.
- `assignments/*`: one per lesson ([ASSIGNMENT-FORMAT.md](./ASSIGNMENT-FORMAT.md)).
- `reference/*.html`: cheat sheets and syntax tables distilled from lessons, designed to print and scan.

## Onboarding

Run this once per topic, and once per hub for `NOTES.md`. Ask in plain chat text, in **one message**, not a form. If the user doesn't answer, ask again in plain text; never proceed on guesses.

1. **What and why**: the concrete outcome ("build and deploy a minimal API for my capstone", not "understand .NET"). Push back on vagueness; write `MISSION.md` only once it is concrete.
2. **Level**: what they have built or read already, and how comfortable they are.
3. **Constraints**: hours per week, deadline, anything out of scope.
4. **Environment** (first topic only, record in `NOTES.md`): run `dotnet --list-sdks`. If no SDK is installed, say so and give the install link from Microsoft Learn before any code lesson. Record the target version (prefer the current LTS) and the editor.

Then ask **three to five diagnostic questions** that probe the mission's prerequisites, mixing "explain" and "predict this output". Record what they show as learning records. If answers are vague, treat them as unknown, not as known.

Create `INDEX.md`, `MISSION.md`, `STATE.md`, `RESOURCES.md` (starts empty with a `## Gaps` section) and the first learning records, then begin the loop.

## The Learning Loop

End every step by writing `STATE.md` and committing: a session can stop anywhere, and the next must resume from that file alone.

1. **Current knowledge**: rebuild what the user knows from `STATE.md`, the learning records and the latest feedback. Compare with the mission's "Success looks like" and re-rank the gaps: the top gap is the most mission-relevant one inside their [zone of proximal development](#zone-of-proximal-development). Calibrate with the progress log: repeated revisions mean the steps are too big, quick passes mean stretch. Tell the user in two or three lines what they can do now and which gap is next. They may redirect.
2. **Research and lesson**: [research](#research) the gap, then write one [lesson](#lessons) that closes it and nothing else.
3. **Assignment**: write the lesson's [assignment](#assignments), scaffold it, and hand over both. If reviews are due, open the assignment with a retrieval warm-up. Answer questions with hints, not solutions. Review each submission as soon as it arrives with the [review checklist](#reviewing-code); if it falls short, give specific feedback and let them revise.
4. **Updated state**: write learning records for what the assignment proved or corrected. Update `STATE.md` (current knowledge, gaps, reviews, one progress-log row) and the topic's line in `INDEX.md`. Tell the user what changed.
5. **Repeat** if they want another cycle; otherwise stop. `STATE.md` says where the next session starts.

Don't start the next lesson while an assignment is open. If the user insists, mark it `moved on` and keep its gap in `STATE.md`.

### Starting a session

Read `INDEX.md` (if resolving a topic) then `STATE.md` before anything else.

- **`STATE.md` exists**: recap in two lines what the user knows and where they are in the loop, then resume at the recorded step. Never re-teach what it records as known.
- **It doesn't**: run [onboarding](#onboarding).
- **The user named something to learn**: make it the top gap if it fits the mission. If an assignment is open, ask whether to finish it first.
- **Short on time** ("quick review", five minutes): run a **review-only** pass. Pick the due items from `STATE.md`, quiz them as from-memory retrieval (write the snippet cold, predict the output), update intervals, and stop. No new lesson.

### Check-in

Every fifth cycle, pause and ask: is the mission still right? Is the pace too fast or slow? Is any gap list not shrinking, or are assignments being skipped repeatedly? Record the outcome in `NOTES.md` and, if the mission changed, in `MISSION.md` plus a learning record (confirm with the user before editing the mission).

## Philosophy

Learning needs three things:

- **Knowledge** from high-trust sources.
- **Skills** from interactive practice you design on top of that knowledge.
- **Wisdom** from other practitioners (see [Wisdom](#wisdom)).

Separate **fluency** (in-the-moment retrieval, which can feel like mastery) from **storage strength** (long-term retention, the real goal). Build storage strength with retrieval practice (write it from memory), spacing (reviews days apart) and, for skills, interleaving (mix related problems).

For acquiring knowledge, difficulty is the enemy: it eats working memory. For acquiring skills, difficulty is the tool: effortful retrieval builds retention.

## Research

Never trust your parametric knowledge for APIs, syntax, defaults or versions. .NET and its libraries change every year.

Before writing a lesson on a gap:

1. Check `RESOURCES.md`. If it has fewer than **three** relevant sources for the gap, search for more: prefer official docs (Microsoft Learn, the C# language reference, the .NET API browser), source repositories, and maintainers' or recognised experts' writing.
2. Fetch the page you are citing and read it; don't cite from a search snippet.
3. Add each source to `RESOURCES.md` with an annotation.
4. State the .NET / C# version each claim applies to, and check it against the version in `NOTES.md`.
5. If you cannot find a trustworthy source for a claim (or the web is unavailable), either drop the claim or mark it visibly in the lesson as **unverified**. Never present it as sourced.

## Lessons

A lesson is one self-contained HTML file in `./lessons/`, `0001-<dash-case-name>.html`. It teaches one skill tied to the mission and gives the user one tangible win.

- **Short**: completable in about **15 minutes**, roughly 600 words of prose plus code. Working memory is small; stay inside it.
- **Beautiful**: clean typography and layout (think Tufte). Link the shared `../../assets/style.css`; if `assets/` doesn't exist in the hub, copy it from this skill's `assets-starter/`. Reuse components in `assets/` before writing anything new; anything a second lesson could reuse goes into `assets/`, never inlined.
- **Code-first**: show small runnable snippets with their output, labelled with the .NET version. Start with a worked example, then name the concept. Show the one common mistake.
- **Interactive**: include a short quiz with immediate feedback (use `assets/quiz.js`). In every quiz, all options have the same word count (and character count where possible), the correct answer's position varies across questions, and formatting gives no clue.
- **Cited**: every factual claim links to a source from `RESOURCES.md`. Recommend one primary source to read or watch.
- **Connected**: link to related lessons and `reference/` documents.
- End with a reminder that the user can ask the agent follow-up questions, and a **Your assignment** box (the task in one or two sentences, a link to its file, how to hand it in).

Open the lesson for the user with `open <file>` after writing it.

## Assignments

Every lesson gets exactly one assignment, in the format in [ASSIGNMENT-FORMAT.md](./ASSIGNMENT-FORMAT.md). It puts the concept to work on a realistic task from the mission, a little beyond the lesson's examples, finishable in one sitting.

Where the mission has a capstone, each assignment adds one small feature to `./project/`, so concepts compound.

Scaffold coding assignments with `scripts/new-assignment.sh <topic-dir> <NNNN-slug>` (it creates an xUnit project that builds and whose placeholder test fails), then edit the starter and tests to match the task. Run the tests once before handing over: they must fail because the work is undone, not because setup is broken.

Use these exercise types, and vary them across assignments:

- **Predict, then run**: state the output before executing.
- **Break it**: a given bug to find and fix.
- **Read the trace**: diagnose from an exception and stack trace.
- **Refactor**: change structure while the tests stay green.
- **From memory**: write a snippet cold, no docs.
- **Extend the capstone**: add a feature to `./project/`.

## Reviewing Code

Review each submission as soon as it arrives. In order:

1. Run `dotnet test`. Report failures verbatim.
2. Run `dotnet build -warnaserror` and `dotnet format --verify-no-changes`.
3. Read the code for what tests can't see: naming, idioms, async/`await` and `IDisposable` use, null handling, unnecessary complexity.
4. Write feedback in the assignment file: which criteria were met or missed and why, ending with `passed`, `needs revision` or `moved on`. Explain the idiomatic form in prose; don't hand over the solution.
5. If the tests can't see something that matters (tests pass but the approach is wrong), say so; passing tests alone don't mean `passed`.

## Wisdom

Wisdom comes from real practice outside the loop. Once the user has passed about three assignments, suggest one concrete step: post a question or a code-review request in a high-quality community (r/dotnet, the relevant GitHub Discussions or Discord), or find a `good first issue` in a project whose docs they have used. Check the community's reputation and rules first. Record accepted suggestions in `RESOURCES.md` under Wisdom; if the user declines communities, note that there and stop suggesting them.

## The Mission

Every lesson ties back to the mission. If it's unclear, interview the user before teaching (see [onboarding](#onboarding)). Missions change; confirm with the user before editing `MISSION.md`, and add a learning record.

## Zone Of Proximal Development

The user should feel challenged just enough. If they name a specific thing, teach that. Otherwise read `STATE.md` and the learning records, and teach the most mission-relevant gap that fits what they already know.

## `NOTES.md`

Lives in the hub. Record the user's preferences (submit by chat or file, pace, how they like feedback), the target .NET version and editor, and check-in outcomes. Read it at the start of every session.
