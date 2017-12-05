# LaTeX Makefile v1.0 -- LaTeX + PDF figures + PNG figures

ALL=$(wildcard *.tex content/*.tex defense/index.html figures/svg/*.svg)
MAIN=main.tex
LATEX=rubber --pdf
SHELL=/bin/bash

FIGURES_SVG=$(wildcard figures/svg/*.svg)
FIGURES_PDF=$(subst svg/,pdf/,$(FIGURES_SVG:.svg=.pdf))
FIGURES_PNG=$(subst figures/svg/,defense/images/,$(FIGURES_SVG:.svg=.png))

all: #  $(FIGURES_PDF) $(FIGURES_PNG)  ## Build full thesis (LaTeX + figures)
	$(LATEX) $(MAIN)                # main run
	bibtex $(MAIN:.tex=)            # bibliography
	$(LATEX) $(MAIN)                # incremental run

clean:  ## Clean LaTeX and output figure files
	rubber --clean $(MAIN)

# figures/pdf/%.pdf: figures/svg/%.svg  ## Figures for the manuscript
# 	nkscape -C -z --file=$< --export-pdf=$@

# defense/images/%.png: figures/svg/%.svg  ## Figures for my defense slides
# 	inkscape -C -z --file=$< --export-png=$@

watch:  ## Recompile on any update of LaTeX or SVG sources
	while [ 1 ]; do          \
		inotifywait $(ALL);    \
		sleep 0.01;            \
		make all;              \
		echo "\n----------\n"; \
		done

# help:  # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#     @grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
# .DEFAULT_GOAL := help
# .PHONY: help