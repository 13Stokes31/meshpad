# ROADMAP — meshpad

> **Published on Typst Universe.** `@preview/meshpad:0.1.0` went in through
> [#5585](https://github.com/typst/packages/pull/5585), merged by `elegaanz` on
> 2026-08-17 with no changes requested.
>
> **Done in 0.1.1 (2026-08-31):** `size`, `step` and `major-every` are validated.
> Until now only `kind` and `lines` were, and the gap was reachable from the
> published package: `step: 0` died with "cannot divide by zero" pointing at
> `lib.typ`, `major-every: 0` with "divisor must not be zero", and a negative
> `step`, a negative or fractional `major-every`, and a zero or negative `size`
> all **compiled in silence** and drew nonsense.
>
> Two things worth knowing about the fix. Positivity is tested as `v > v * 0`,
> against the zero of the value's own type, because `size`/`step` accept Typst
> lengths and `5mm > 0` does not compile — a length and an integer cannot be
> compared. And the type check is "all lengths or all plain numbers", not "all
> the same type": `size: (6, 4)` with `step: 0.5` mixes int and float and is
> perfectly valid, so a stricter check would have broken the documented default.
> Mixing a length with a plain number is what fails, deep inside CeTZ, and now
> says so.
>
> The must-fail cases used to sit commented out at the end of
> `tests/regression.typ`, which meant nobody ever ran them. They now live in
> `tests/errors.sh`: 10 cases, each asserting its own `meshpad:` message.

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
- **A minimal CI workflow** compiling `tests/regression.typ` and running
  `tests/errors.sh` against the declared minimum Typst version and a current one.
  The Universe PR validates the initial publication, but nothing validates later
  changes to the repository. Not urgent for a package this size, but it is the
  only real gap left in the testing story.
- A case with very small sizes would help delimit unit errors, now that mixing
  units is rejected outright.

## Before publishing to Typst Universe

- [x] Confirm the name `meshpad` is free in the Typst package index. (2026-08-15,
  checked against `packages.typst.org/preview/index.json`)
- [x] Create the GitHub repository `13Stokes31/meshpad`, push. (2026-07-21)
- [x] Manual pass on `TESTING.md`. (2026-08-15, Typst 0.15.1)
- [x] Submit a PR to `typst/packages`: [#5585](https://github.com/typst/packages/pull/5585),
  opened 2026-08-15. Lint, Test and the Universe bot all green. Tagged `v0.1.0`
  here so the README images are permalinks, which is what the bot asks for.
- [x] Reviewed and merged. (2026-08-17, by `elegaanz`, no changes requested)

## Publishing 0.1.1

- [x] Argument validation + `tests/errors.sh`. (2026-08-31)
- [x] Manual pass on `TESTING.md`. (2026-08-31)
- [x] Tag `v0.1.1` so the README image links are permalinks, as the Universe bot
  asks for. (2026-08-31)
- [x] Submit the PR to `typst/packages`:
  [#5727](https://github.com/typst/packages/pull/5727), opened 2026-08-31 from
  the `meshpad-0.1.1` branch of the `13Stokes31/packages` fork. A new version is
  a **new folder**: `packages/preview/meshpad/0.1.1/` with just `lib.typ`,
  `LICENSE`, `README.md` and `typst.toml`. 0.1.0 is untouched, because published
  versions are immutable.
- [ ] Waiting on a human reviewer. If they ask for changes, edit the files in
  `packages/preview/meshpad/0.1.1/` on that branch and push — the PR updates
  itself.
