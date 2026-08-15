// Regression battery for meshpad.
// Compile-only check: `typst compile --root .. tests/regression.typ out.pdf`
// must succeed and each page must match the expected result in the comment.
#import "../lib.typ": grid-paper
#set page(width: auto, height: auto, margin: 1cm)

// 1. square, defaults (both directions, no majors)
#grid-paper(size: (6, 4), kind: "square", step: 0.5)
#pagebreak()

// 2. square, major-every
#grid-paper(size: (6, 4), kind: "square", step: 0.5, major-every: 2)
#pagebreak()

// 3. square, lines: horizontal (ruled paper)
#grid-paper(size: (6, 4), kind: "square", step: 0.5, lines: "horizontal")
#pagebreak()

// 4. square, lines: vertical
#grid-paper(size: (6, 4), kind: "square", step: 0.5, lines: "vertical")
#pagebreak()

// 5. dot grid, no majors
#grid-paper(size: (6, 4), kind: "dot", step: 0.5)
#pagebreak()

// 6. dot grid, major-every
#grid-paper(size: (6, 4), kind: "dot", step: 0.5, major-every: 2)
#pagebreak()

// 7. background + custom line/major colors
#grid-paper(
  size: (6, 4), kind: "square", step: 0.5, major-every: 2,
  background: rgb("#fffbe6"), color: rgb("#f0c419"), major-color: rgb("#c9950a"),
)
#pagebreak()

// 8. frame: false
#grid-paper(size: (6, 4), kind: "square", step: 0.5, frame: false)
#pagebreak()

// 9. non-square size, step that doesn't divide it evenly (edge coverage)
#grid-paper(size: (7, 3), kind: "square", step: 0.6, major-every: 3)
#pagebreak()

// 10. small step (density check)
#grid-paper(size: (4, 3), kind: "dot", step: 0.2)
#pagebreak()

// 11. explicit Typst length units instead of plain numbers
#grid-paper(size: (5cm, 3cm), kind: "square", step: 5mm, major-every: 2)

// NOTE: these two are EXPECTED to error, on purpose — uncomment one at a time to
// check the message. A bad `kind` or `lines` used to draw an empty frame in silence.
//   #grid-paper(size: (6, 4), kind: "isometric")
//   #grid-paper(size: (6, 4), lines: "horizontales")
