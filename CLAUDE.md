# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this repo is

The source of the free e-book **"Building Microservices with Containers: A Practical Guide"** by Anji Keesari, published as an MkDocs Material site at https://microservices.anjikeesari.com. It is content, not an application: there is no application code to compile. All rights reserved (see LICENSE); never copy content in from other sources.

## Commands

```bash
pip install -r requirements.txt   # mkdocs-material + mkdocs-print-site-plugin
mkdocs serve                      # live preview at http://127.0.0.1:8000/
mkdocs build --strict             # must pass before any change is considered done
```

CI (`.github/workflows/ci.yml`) runs `mkdocs build --strict` on every PR and push, and deploys to GitHub Pages on pushes to `main`.

## Layout

- `docs/microservices/N.<slug>.md` : chapters 1-11, images in `docs/microservices/images/<topic>/`
- `docs/introduction/` : author, acknowledgments, introduction, `toc.md` (hand-maintained)
- `docs/appendix/` : cheat sheets
- `docs/overrides/` : Material theme overrides (`home.html`, `404.html`, `main.html`, footer)
- `docs/stylesheets/`, `docs/javascripts/` : extra CSS and JS, registered in `mkdocs.yml`
- `mkdocs.yml` : site config **and the `nav:` list**, so every new page must be added there
- `drafts/` : local-only notes, git-ignored. Do not publish or move into `docs/`

## Chapter template

Each lab chapter follows this order: `# Chapter-N: Title`, Introduction, Technical Scenario, Objective (list of `Step-N` items), Prerequisites, Architecture Diagram, one `## Step-N: ...` section per step, Conclusion, References.

## Writing conventions

- Second person ("you"), friendly and practical; short paragraphs, numbered steps.
- Commands and config go in fenced code blocks with a language tag. Keep shell output examples after a `# output` comment.
- External links use `{:target="_blank"}`; images use `[![Alt text](images/x.png)](images/x.png){:target="_blank"}`.
- Use lowercase for repo and image names.
- **Never put real credentials in examples.** Use the placeholder `replaceme` for every password or secret, and say that demo values are for learning only.
- When you add, rename or retitle a heading, update the links in `docs/introduction/toc.md`: anchors are generated from the heading text and break silently otherwise (strict build reports them).
- Image files must be referenced from a page. Delete images that no longer are.

## Before finishing a change

1. `mkdocs build --strict` passes with no warnings or broken-link/anchor messages.
2. New pages are in `nav:` and `toc.md`.
3. No secrets, no `.DS_Store`, no build output (`site/`) committed.
4. Keep the license and copyright notices intact. Do not change the license without the author's say-so.
