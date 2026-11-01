# CLAUDE.md

Source of the free e-book **"Building Microservices with Containers: A Practical Guide"** by Anji Keesari: Material for MkDocs, Markdown content, deployed to GitHub Pages at https://microservices.anjikeesari.com. There is no application code; "not breaking it" means the site builds and links resolve. All rights reserved (see LICENSE): never copy in content from other sources.

## Commands

```powershell
py -m pip install -r requirements.txt   # mkdocs-material + mkdocs-print-site-plugin
py -m mkdocs serve                      # http://127.0.0.1:8000/
py -m mkdocs build --strict             # must pass before every commit; this is what CI runs
```

- On this Windows machine plain `python` is the Store shim; use `py -m ...` or a venv.
- Set `NO_MKDOCS_2_WARNING=1` to silence the Material end-of-life banner.
- Never run `mkdocs gh-deploy` by hand; CI deploys on push to `main`.

## Operating principles

- **No silent assumptions.** If scope or a requirement is ambiguous, ask. Never present a guess as settled. In docs, an undecided point is a `TODO:`, not an invented default.
- **Stay in scope.** No unrelated files or adjacent cleanup. Smallest change that solves the problem; no new dependency, plugin or script without a demonstrated need.
- **Work through to the end.** Keep going until the task is done, verified, committed and pushed, or a real blocker stops you (information only the user has, or a failure you can't fix). Then state the blocker, what you tried and what's needed. Fix failures you caused and update affected docs without asking, and report it. Don't wait for approval on steps that follow obviously from the task.
- **Verify before claiming.** Never say the site builds or a check passes unless a run in this session showed it. Run the narrowest check first.

## Layout

- `docs/microservices/N.<slug>.md`: chapters 1-11; images in `docs/microservices/images/<topic>/`
- `docs/introduction/`: author, acknowledgments, introduction, `toc.md` (hand-maintained)
- `docs/appendix/`: cheat sheets
- `docs/overrides/`: theme overrides; `docs/stylesheets/`, `docs/javascripts/`: extra CSS/JS
- `mkdocs.yml`: site config **and the hand-curated `nav:`**; a new page is invisible until added there
- `samples/`: tested reference code for chapters 4-11; chapter Dockerfiles and compose files must match it. Change the sample first, test it with `docker build`/`docker compose up`, then update the chapter
- `drafts/`: local-only, git-ignored; never move into `docs/`

## Workflow rules

- Don't add external scripts to `extra_javascript` without vetting (polyfill.io was removed for supply-chain reasons). Review `docs/overrides/` HTML changes for injected scripts.
- No secrets or private data anywhere. Every password in examples is the placeholder `replaceme`; say demo values are for learning only.
- Don't commit large binaries, `.DS_Store` or `site/`. Delete images no page references.
- Preserve the author's voice when editing prose: fix errors and structure, don't rewrite style.
- Changing a heading changes its anchor: update `docs/introduction/toc.md` in the same change (the strict build reports broken anchors).
- Keep license and copyright notices intact; don't change the license without the author's say-so.

## Chapter template

`# Chapter-N: Title`, Introduction, Technical Scenario, Objective (list of `Step-N`), Prerequisites, Architecture Diagram, one `## Step-N:` section per step, Conclusion, References. Second person, short paragraphs, numbered steps; fenced code with a language tag; shell output after a `# output` comment. Links `{:target="_blank"}`; images `[![Alt text](images/x.png)](images/x.png){:target="_blank"}`; lowercase repo and image names.

## Keeping docs in sync

When behavior, structure or tooling changes, update every affected document in the same task and list them in the reply: `README.md` (usage, prerequisites, structure, chapter table), `helper.ps1` and `.github/workflows/ci.yml` (dev workflow, CI), and this file (layout, standards, workflow rules).

## Commits

- One logical change per commit; stage by path, not `git add -A`.
- Message `type: summary` (`feat`, `fix`, `docs`, `chore`, `ci`), imperative, under ~70 characters, body when the why isn't obvious.
- Commit only when `mkdocs build --strict` passes.
- When a task is complete and verified, commit and push to `main` without asking; CI deploys the live site. Never push a failing build, never force-push, and don't push another session's uncommitted work.
- Push once per completed task, not per file. Report the commit hash(es) pushed.

## Working alongside other sessions

Treat uncommitted changes you didn't make as another session's work. Don't revert or overwrite them; ask before editing around something that looks unfinished.

## Writing style for docs

Applies to README, CLAUDE.md and commit messages (not the book chapters): condensed, each thing said once, tables and bullets over prose, current facts rather than edit history.

## Next steps

End every development response with a **Next steps** list of 2-4 numbered suggestions for *new* tasks, grounded in a real gap below. Mark one **(Recommended)** and list it first. If there is nothing worth suggesting, say so in one line.

Anything relevant to the current task (commit, push, doc sync, fixing breakage you caused, deleting orphaned images, `toc.md` updates) is done as part of the task, never listed as a next step.

## Known gaps

- Azure DevOps/ACR dependence in chapters 1-7 and 10 not reviewed. TODO: confirm with the author whether to generalize.
- Chapter screenshots and pasted output for chapters 4-7 predate the .NET 10 / Node 24 / Vite update; commands match `samples/`, images may not.
- README: GitHub path `akeesari/microservices` is assumed, and there is no tutoring/mentoring call-to-action. TODO: confirm with the author.
- No secret scan or link check in CI.
- Material for MkDocs reaches end of life on 2027-05-05; a Zensical migration will be needed eventually.
