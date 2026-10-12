# TESTING — meshpad

Manual verification checklist. Automated coverage is two batteries — the
compile-only one in `tests/regression.typ` and the must-fail one in
`tests/errors.sh`; this file is for the things a human should eyeball.

> Full pass done on 2026-08-15 with Typst 0.15.1, ahead of the 0.1.0 submission to
> Typst Universe. Re-run it whenever `lib.typ` changes.
>
> 0.1.1 (2026-08-31) only adds argument checks, which are covered end to end by
> `tests/errors.sh` — 10 cases, each asserting its `meshpad:` message. Nothing
> below changes, but the drawing pages are worth a glance after re-rendering,
> since the asserts run before every draw.

Run both with:

```sh
typst compile --root .. tests/regression.typ tests/regression.pdf
sh tests/errors.sh          # from the repository root
```

Then check, page by page:

- [x] **Square, defaults** — full grid, all lines the same (minor) color.
- [x] **Square, `major-every: 2`** — every 2nd line (starting at the edge) is
  thicker/darker than the rest.
- [x] **`lines: "horizontal"`** — only horizontal lines (ruled/pautado paper), no
  verticals, still framed.
- [x] **`lines: "vertical"`** — only vertical lines.
- [x] **Dot grid, defaults** — evenly spaced dots, no frame overlap issues.
- [x] **Dot grid, `major-every: 2`** — every 2nd dot in both directions is bigger
  and darker.
- [x] **Custom `background`/`color`/`major-color`** — fill shows behind the
  pattern; minor and major lines use the given colors, not the defaults.
- [x] **`frame: false`** — no border rectangle drawn.
- [x] **Non-divisible `step`** (e.g. `size: (7,3), step: 0.6`) — grid stops at or
  before the edge, no overflow past the frame, no crash.
- [x] **Small `step`** (dense grid) — renders without becoming illegibly slow or
  visually solid.
- [x] **Explicit length units** (`size: (5cm, 3cm), step: 5mm`) — same result as
  the equivalent plain numbers (`size: (5, 3), step: 0.5`).

- [x] **Nothing valid got rejected** — the eleven pages above still render. The
  argument checks added in 0.1.1 run before any drawing, so if one of them were
  too strict, a legitimate call would fail instead of drawing. The mixed
  int/float case (`size: (6, 4)` with `step: 0.5`) is the one to watch: it is
  valid on purpose and must keep working.

## 0.1.2: faster dots, clean line crossings (2026-10-12)

Pages 12-14 of `tests/regression.typ` are new. Compared by script against the
previous output, on Typst 0.15.1 and on 0.14.0 (the declared minimum): every
page keeps its exact size and differs only in
anti-aliasing (dots) or at the crossings (lines). Still to eyeball:

- [ ] **Dot pages (5, 6, 10, 12, 13)** — dots are round, sit on the grid and on
  the frame, and the major ones are bigger and darker. On page 12 there are no
  dots in the strip on the right.
- [ ] **Page 14** — a full A4 of dots 1 mm apart compiles at once and is not a
  grey blur when zoomed in.
- [ ] **Line pages with majors (2, 7, 9, 11)** — zoomed in, a major line is not
  interrupted where a minor line crosses it.
- [ ] **Printed, or opened in a viewer other than the usual one** (a browser,
  for instance) — the dots are still dots. They are now very short dashes with
  round caps; checked in Typst's PNG export and in poppler, nowhere else.

## Gallery

- [x] `gallery/g1.png … g4.png` match the current output after any code change:
  `typst compile --root .. --format png --ppi 150 gallery/examples.typ gallery/g{p}.png`
