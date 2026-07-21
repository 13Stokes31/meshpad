// Source for the README gallery images. Render with:
//   typst compile --root .. --format png --ppi 150 gallery/examples.typ gallery/g{p}.png
#import "../lib.typ": grid-paper
#set page(width: auto, height: auto, margin: 8pt, fill: white)

// g1 — classic square grid, major line every 2 steps (milimetrado)
#grid-paper(size: (6, 4), kind: "square", step: 0.5, major-every: 2)
#pagebreak()

// g2 — dot grid, major dot every 2 steps
#grid-paper(size: (6, 4), kind: "dot", step: 0.5, major-every: 2)
#pagebreak()

// g3 — ruled paper (horizontal lines only), wider than tall
#grid-paper(size: (10, 3), kind: "square", step: 0.5, lines: "horizontal")
#pagebreak()

// g4 — custom background and line colors
#grid-paper(
  size: (6, 4), kind: "square", step: 0.5, major-every: 2,
  background: rgb("#fffbe6"), color: rgb("#f0c419").lighten(20%), major-color: rgb("#c9950a"),
)
