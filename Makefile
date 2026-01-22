# This is a makefile template to be copied & modified. Copy it to
# "Makefile" in your directory and do "chmod u+w Makefile".
# -- Andrew Myers

DOC = draft
#
# change this line to contain the name of the document without extension

TARGETS = $(DOC).pdf
#
# TARGETS could be $(DOC).dvi instead, if there are no figures

TEXS = $(DOC).tex $(wildcard *.tex *.sty)
#
# Add any included TeX files to TEXS

FIGS =
#
# List of postscript figures to be included

include make/commondefs

default: $(TARGETS)

BIBFILE = bibtex/pm-master.bib
#
# Ignore this if you're not using bibtex. Change the $(DOC) part if your bib
# file has a different name from your document

$(DOC).dvi $(DOC).pdf: $(TEXS) $(FIGS) $(DOC).stamp
#
# To use bibtex, add these to dependency list:
# $(DOC).bbl
# 
# To use makeindex, add this to dependency list:
# $(DOC).ind
#
# To use glossaries, add this to dependency list:
# $(DOC).glo

$(DOC).bbl: $(BIBFILE) $(DOC).stamp
$(DOC).ind $(DOC).glo: $(DOC).stamp
$(DOC).ps: $(DOC).dvi $(FIGS)
#
# These are standard dependencies. Shouldn't need to modify these.

$(DOC).tex: paper.tex Makefile
	@printf '\\def\\paperversion{${DOC}}\n\\input{paper}' > $(DOC).tmp
	@if test -r $(DOC).tex && cmp -s $(DOC).tmp $(DOC).tex;   	      \
	    then echo '(No change to $(DOC).tex)'; rm $(DOC).tmp; 	      \
	    else echo '(Rebuilt $(DOC).tmp)'; mv $(DOC).tmp $(DOC).tex;       \
	fi
	@$(MAKE) $(MAKEFLAGS) depend

sinclude .depend.$(DOC)

.PHONY: depend
depend: $(DOC).pdf
	@perl compute_deps.pl $(DOC) >> .depend.$(DOC)
	@/bin/echo "Dependencies recomputed for $(DOC)."

LDIRT = .depend.$(DOC)

include $(COMMONRULES)
