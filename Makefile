# config
MAIN=paper
BIB=lit.bib
# this must be always at least "." (otherwise things might be written to "/")
OUTDIR=build

# Variables for later use
TEXFILES=$(shell find . -name "*.tex")
MAINDOCPATH=$(OUTDIR)/$(MAIN).pdf

# generic compilation setup
all: dirsetup $(MAINDOCPATH)

$(MAINDOCPATH): $(TEXFILES) $(BIB)
	latexmk -outdir=$(OUTDIR) -pdf $(MAIN).tex

dirsetup:
	# reproduce dir structure
	if [ ! -z "$(OUTDIR)" ]; then \
		texdirs=$$(find . -name "*.tex" | sed -r 's|/[^/]+$$||' | sort | uniq); \
		for d in $$texdirs; do mkdir -p $(OUTDIR)/$$d ; done \
	fi

clean:
	latexmk -outdir=$(OUTDIR) -CA

clean_all:
	rm -r ./$(OUTDIR)

.PHONY: all diresetup clean clean_all
