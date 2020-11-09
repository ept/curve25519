default:	curve25519.pdf
	pdflatex curve25519

# The minted package does source code syntax highlighting using Pygments: https://pygments.org/
# Pygments must be installed on your system, e.g. using `pip3.8 install Pygments`.
# To allow the document to be built on systems without Pygments, commit the files in the
# _minted-curve25519/ directory to git. Use option finalizecache=true to update the cached
# syntax-highlighted listings, and use option frozencache=true to use that cache.
# With frozencache=true, the -shell-escape option is no longer needed.
refresh-syntax-highlighting:
	sed -e 's/\\usepackage\[.*\]{minted}/\\usepackage[finalizecache=true]{minted}/' -i '' curve25519.tex
	pdflatex -shell-escape curve25519
	sed -e 's/\\usepackage\[.*\]{minted}/\\usepackage[frozencache=true]{minted}/' -i '' curve25519.tex

%.pdf:	%.aux %.bbl
	pdflatex $(@:.pdf=)

%.bbl:	references.bib %.aux
	bibtex $(@:.bbl=)

%.aux:	%.tex
	pdflatex $(@:.aux=)

# Code examples
%.o: %.c
	gcc -c -o $@ $<

%.test: %.o tweetnacl.o
	gcc -o $@ $^
	bash -c "diff <(./$@) $(@:%.test=%.out)"

tests: scalarmult.test

clean:
	rm -f *.{aux,log,bbl,blg,pdf,o,test}
