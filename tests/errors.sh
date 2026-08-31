#!/bin/sh
# Cases that MUST fail, each with the message meshpad is expected to give.
#
# These cannot live in regression.typ: a document that must fail to compile
# cannot share a file with documents that must compile. Before this script the
# error cases sat there commented out, so nobody ever ran them.
#
# Usage, from the repository root:   sh tests/errors.sh
set -eu

# The case file has to live inside the project root, or typst refuses to compile
# it ("source file must be contained in project root"); only the PDF can go out.
caso=tests/.errors-case.typ
salida_pdf=$(mktemp -d)
trap 'rm -f "$caso"; rm -rf "$salida_pdf"' EXIT
fallos=0

comprueba() {
  descripcion=$1
  llamada=$2
  esperado=$3
  printf '#import "../lib.typ": grid-paper\n#%s\n' "$llamada" > "$caso"
  salida=$(typst compile --root . "$caso" "$salida_pdf/case.pdf" 2>&1 || true)
  if printf '%s' "$salida" | grep -qF "$esperado"; then
    printf '  ok    %s\n' "$descripcion"
  else
    printf '  FALLO %s\n        esperaba: %s\n        obtuvo:   %s\n' \
      "$descripcion" "$esperado" "$(printf '%s' "$salida" | head -1)"
    fallos=$((fallos + 1))
  fi
}

echo "meshpad: casos que deben fallar"

comprueba 'kind desconocido' \
  'grid-paper(kind: "isometric")' \
  'meshpad: unknown kind'
comprueba 'lines desconocido' \
  'grid-paper(lines: "horizontales")' \
  'meshpad: unknown lines'

comprueba 'step cero' \
  'grid-paper(size: (4, 3), step: 0)' \
  'meshpad: step must be positive'
comprueba 'step negativo' \
  'grid-paper(size: (4, 3), step: -0.5)' \
  'meshpad: step must be positive'

comprueba 'size cero' \
  'grid-paper(size: (0, 0))' \
  'meshpad: size must be positive'
comprueba 'size negativo' \
  'grid-paper(size: (-4, 3))' \
  'meshpad: size must be positive'

comprueba 'major-every cero' \
  'grid-paper(size: (4, 3), major-every: 0)' \
  'meshpad: major-every must be a positive whole number'
comprueba 'major-every negativo' \
  'grid-paper(size: (4, 3), major-every: -2)' \
  'meshpad: major-every must be a positive whole number'
comprueba 'major-every decimal' \
  'grid-paper(size: (4, 3), major-every: 2.5)' \
  'meshpad: major-every must be a positive whole number'

comprueba 'unidades mezcladas' \
  'grid-paper(size: (5cm, 3cm), step: 0.5)' \
  'meshpad: size and step must be all plain numbers or all Typst lengths'

if [ "$fallos" -eq 0 ]; then
  echo "todos pasan"
else
  echo "$fallos caso(s) sin el mensaje esperado"
  exit 1
fi
