#!/bin/bash
for t in *.tex; do
  b=${t%.tex}
  pdflatex $b
  gs -sDEVICE=png16m -dDownScaleFactor=2 -r678 -o $b.png $b.pdf
  
done