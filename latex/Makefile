#### Makefile for Latex project ####
# figures in /figsvg
# sections in /sections


.PHONY: clean

# list of temporary file extensions
TEMPFILES = *.log *.lot *.lof *.toc *.out *.aux *.bbl *.blg *.pdf *.glo *.ist *.acn *.alg *.acr *.tdo

MAKEDIR := $(shell pwd)
IMGDIR = $(MAKEDIR)/fig
SECTIONSDIR = $(MAKEDIR)/sections
SKETCHDIR = $(MAKEDIR)/figsvg
sections = $(SECTIONSDIR)/*.tex
additionaldeps = 

SVGSRC	:= $(notdir $(wildcard $(SKETCHDIR)/*.svg))
PDF	:= $(addprefix $(IMGDIR)/, $(SVGSRC:%.svg=%.pdf))

RM = /bin/rm -f
OUT = /dev/null 2>&1

RERUN = "(There were undefined references|Rerun to get citations correct.|Rerun to get cross-references right.|Table widths have changed. Rerun LaTeX.)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"

# put the name of the main tex file here
FILE = name

$(FILE).pdf: $(FILE).tex $(sections) $(additionaldeps) $(PDF)
	@echo "changes found. regenerating"
	@pdflatex -file-line-error $(FILE).tex
#	@# make list of acronyms
#	@makeindex -s $(FILE).ist -t $(FILE).alg -o $(FILE).acr $(FILE).acn > $(OUT)
	@# run bibtex if needed
	@egrep -c $(RERUNBIB) $(FILE).log > $(OUT) && (echo "run bibtex"; bibtex $(FILE) > $(OUT); pdflatex $(FILE) > $(OUT)); true
	@# rerun to get citations correct
	@egrep -c $(RERUN) $(FILE).log > $(OUT) && (echo "rerun pdflatex for cross-references or citations"; pdflatex $(FILE) > $(OUT)); true
	@# output pdflatex output if there are undefined references
	@egrep -c $(RERUN) $(FILE).log > $(OUT) && (echo "Problem with references";pdflatex $(FILE) -file-line-error); true

# the directory is given as a order-only prerequisite
$(PDF): | $(IMGDIR)

$(IMGDIR):
	mkdir -p $(IMGDIR)

$(IMGDIR)/%.pdf : $(SKETCHDIR)/%.svg
	inkscape $< --export-pdf=$@ --export-area-page
	# fix interpolation problem in inkscape svg export
	sed -i 's/\/Interpolate true/\/Interpolate false/g' $@

clean:
	$(RM) $(TEMPFILES)
