#!/bin/bash
pandoc tutorial.md --template eisvogel --listings --pdf-engine=xelatex  --from markdown --number-sections -V book=true --top-level-division=chapter -V classoption=oneside --reference-links -V colorlinks --toc  -o tutorial.pdf

