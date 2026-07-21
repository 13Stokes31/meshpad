# TESTING — meshpad

Manual verification checklist. Automated coverage is the compile-only battery in
`tests/regression.typ`; this file is for the things a human should eyeball.

Render the battery with:

```sh
typst compile --root .. tests/regression.typ tests/regression.pdf
```

Then check, page by page:

- [ ] **Square, defaults** — full grid, all lines the same (minor) color.
- [ ] **Square, `major-every: 2`** — every 2nd line (starting at the edge) is
  thicker/darker than the rest.
- [ ] **`lines: "horizontal"`** — only horizontal lines (ruled/pautado paper), no
  verticals, still framed.
- [ ] **`lines: "vertical"`** — only vertical lines.
- [ ] **Dot grid, defaults** — evenly spaced dots, no frame overlap issues.
- [ ] **Dot grid, `major-every: 2`** — every 2nd dot in both directions is bigger
  and darker.
- [ ] **Custom `background`/`color`/`major-color`** — fill shows behind the
  pattern; minor and major lines use the given colors, not the defaults.
- [ ] **`frame: false`** — no border rectangle drawn.
- [ ] **Non-divisible `step`** (e.g. `size: (7,3), step: 0.6`) — grid stops at or
  before the edge, no overflow past the frame, no crash.
- [ ] **Small `step`** (dense grid) — renders without becoming illegibly slow or
  visually solid.
- [ ] **Explicit length units** (`size: (5cm, 3cm), step: 5mm`) — same result as
  the equivalent plain numbers (`size: (5, 3), step: 0.5`).

## Gallery

- [ ] `gallery/g1.png … g4.png` match the current output after any code change:
  `typst compile --root .. --format png --ppi 150 gallery/examples.typ gallery/g{p}.png`
