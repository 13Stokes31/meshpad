# ROADMAP — meshpad

## Possible improvements (optional)

- **Isometric grid** (`kind: "isometric"`) — deferred from v0.1 on purpose: it needs
  three line directions (0°/60°/120°) instead of two, meaningfully more geometry
  than square/dot, and nobody has asked for it yet. It is no longer named in the
  package description, and asking for it now raises a clear error instead of
  drawing an empty frame.
- **Centre the leftover strip** when `size` is not a whole multiple of `step`:
  today the remainder is left against the far edge (documented in the README);
  splitting it in two halves would look tidier in print. Deliberate for v0.1.
- More localization isn't needed — the package draws no text.

## Before publishing to Typst Universe

- [x] Confirm the name `meshpad` is free in the Typst package index. (2026-08-15,
  checked against `packages.typst.org/preview/index.json`)
- [x] Create the GitHub repository `13Stokes31/meshpad`, push. (2026-07-21)
- [x] Manual pass on `TESTING.md`. (2026-08-15, Typst 0.15.1)
- [ ] Submit a PR to `typst/packages` (`packages/preview/meshpad/0.1.0/`).
