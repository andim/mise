#### Makefile for Latex file ####
.PHONY: clean
# don't remove pdf file if it has been newly generated using target s%
.PRECIOUS: %.pdf

# list of temporary file extensions
TEMPFILES = *.log *.lot *.lof *.toc *.out *.aux *.bbl *.blg *.pdf *.glo *.ist *.acn *.alg *.acr *.tdo

MAKEDIR := $(shell pwd)
SECTIONSDIR = $(MAKEDIR)
sections = $(SECTIONSDIR)/*.tex
additionaldeps = 
SHAREDREFDIR = 

RM = /bin/rm -f
OUT = /dev/null 2>&1

RERUN = "(There were undefined references|Rerun to get citations correct.|Rerun to get cross-references right.|Table widths have changed. Rerun LaTeX.)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"


# show pdf to corresponding tex file
# % = filename (without extension)
s%: %.pdf
	@evince $< > $(OUT) &

%.pdf: %.tex $(sections) $(additionaldeps) $(makeimages)
	@echo "changes found. regenerating"
	@pdflatex -file-line-error $<
	@# run bibtex if needed
	@egrep -c $(RERUNBIB) $(basename $<).log > $(OUT) && (echo "run bibtex"; bibtex $(basename $<) > $(OUT); pdflatex $< > $(OUT)); true
	@# rerun to get citations correct
	@egrep -c $(RERUN) $(basename $<).log > $(OUT) && (echo "rerun pdflatex for cross-references or citations"; pdflatex $< > $(OUT)); true
	@# output pdflatex output if there are undefined references
	@egrep -c $(RERUN) $(basename $<).log > $(OUT) && (echo "Problem with references";pdflatex $< -file-line-error); true

library.bib: $(SHAREDREFDIR)/library.bib
	grep -Ev 'abstract =|issn =|isbn =|pmid =|keywords =|file =|doi =|url =|archivePrefix =|eprint =|arxivId =' $(SHAREDREFDIR)/library.bib >library.bib

clean:
	$(RM) $(TEMPFILES)
