# make

Makefile support for LaTeX. The file makefile.tex is a template to be copied to Makefile and edited.

This Makefile automatically runs pdflatex and bibtex until a fixed point is reached. Since it is a
Makefile, you can set up a build process that builds other files that are used to construct the document,
including generating .tex input files.
