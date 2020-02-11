# config
MAIN=main
BIB=$(MAIN).bib
OUTDIR=build

# Variables for later use
ARCHIVE=arXiv
TEXFILES=$(shell find . -name "*.tex")
MAINDOCPATH=$(OUTDIR)/$(MAIN).pdf

# generic compilation setup
all: dirsetup $(MAINDOCPATH) arXiv

$(MAINDOCPATH): $(TEXFILES) $(BIB)
	latexmk -outdir=$(OUTDIR) -pdf $(MAIN).tex

dirsetup:
	# reproduce dir structure
	if [ ! -z "$(OUTDIR)" ]; then \
		texdirs=$$(find . -name "*.tex" | sed -r 's|/[^/]+$$||' | sort | uniq); \
		for d in $$texdirs; do mkdir -p $(OUTDIR)/$$d ; done \
	fi

# generate arXiv archive
arXiv:
	rm -rf arXiv
	mkdir -p ./$(ARCHIVE)
	rm -rf ./$(ARCHIVE)/*
	cp -r $(TEXFILES) ./$(ARCHIVE)/
	cp -r ./figures ./$(ARCHIVE)/
	cp build/$(MAIN).bbl ./$(ARCHIVE)/

clean:
	latexmk -outdir=$(OUTDIR) -CA

clean-all:
	rm -r ./$(OUTDIR) ./arXiv

.PHONY: all arXiv dirsetup clean clean_all
