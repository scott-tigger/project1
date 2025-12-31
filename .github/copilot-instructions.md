Repository AI assistant notes — project-specific guidance

Purpose: help AI coding agents quickly become productive in this repository while preserving the repository owner's interaction preferences.

Summary of discovered state
- The repository currently contains only a repository-level Copilot instruction file and no obvious source files or manifests (no `package.json`, `pyproject.toml`, `README.md`, or `src/` visible at time of inspection). Keep this in mind and perform discovery before assuming a language or build system.

Human preferences preserved from existing instructions
- The repo owner prefers a tutoring-style interaction: when the human indicates they are learning, prefer to explain concepts and approaches rather than immediately dumping full solutions. Before producing large code changes ask permission.
- The owner previously requested: "Always check the correctness of AI-generated responses." Keep that sentence as a visible reminder in outputs.

Agent working checklist (first actions)
1. Run a repository scan to detect languages, manifests, CI, and tests. Example shell snippet to run locally:

```bash
rg -n --hidden -S "package.json|pyproject.toml|setup.py|requirements.txt|Cargo.toml|go.mod|Makefile|Dockerfile|.github/workflows|README.md" . || true
git status --porcelain
ls -la
```

2. Open any discovered manifest/readme/CI files and extract build/test commands.
3. If no codebase is present (as here), ask the repo owner whether to scaffold a project, add sample files, or connect an external source.

Behavior rules for this repository (non-aspirational, discoverable)
- Before editing code: state the exact files you will change, why, and present a one-sentence plan.
- When the owner indicates they are learning, prefer conceptual explanations and small, incremental edits. Ask before providing full implementations.
- If the owner explicitly requests code edits or scaffolding, produce runnable changes with a minimal README and test harness.

How to surface repository patterns (what to look for)
- Look for language indicators: `package.json` (Node), `pyproject.toml` / `requirements.txt` / `.py` files (Python), `Cargo.toml` (Rust), `go.mod` (Go).
- Inspect `.github/workflows/` for CI commands and matrixes — CI often reveals test/build commands.
- Check `Makefile`, `Dockerfile`, and `README.md` for developer workflows.

Examples from this repo
- See this file: [/.github/copilot-instructions.md](.github/copilot-instructions.md) — it expresses the owner's tutoring preference and the "Always check the correctness of AI-generated responses." reminder.

If you need more context
- Ask the user what language/framework they expect, or request permission to scan the workspace for hidden files and manifests.

Always check the correctness of AI-generated responses.