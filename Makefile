NAME = intro-to-git
TEX  = ${NAME}.tex
TOC  = ${NAME}.toc
DVI  = ${NAME}.dvi
PS   = ${NAME}.ps
PDF  = ${NAME}.pdf

SVG=$(wildcard *.svg)
EPS=$(SVG:.svg=.eps)


.PHONY: run eps ps pdf clean
default: pdf

eps: ${EPS}

ps: ${DVI}
${DVI}: ${TEX} ${EPS}
	-rm -f .${TOC}.sum
	md5sum ${TOC} > .${TOC}.sum || touch .${TOC}.sum
	latex $<
	md5sum -c .${TOC}.sum || latex $<

ps: ${PS}
${PS}: ${DVI}
	dvips $<

pdf: ${PDF}
${PDF}: ${PS}
	ps2pdf $<

${EPS}: %.eps: %.svg
	inkscape -z -E $@ $<

clean:
	-rm -f *~ *.log
	-rm -f ${DVI} ${TOC} ${PS} ${PDF} ${EPS}
	-rm -f $(foreach x,log nav out snm toc dvi aux,${NAME}.${x})
