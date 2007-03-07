
MGP=intro-to-git.mgp
PS=$(MGP:.mgp=.ps)
PDF=$(PS:.ps=.pdf)
SVG=$(wildcard *.svg)
EPS=$(SVG:.svg=.eps)


.PHONY: run eps ps pdf clean
run: ${MGP} eps
	#mgp -x vflib -g 1000x700 ${MGP}
	mgp -g 1000x700 ${MGP}

eps: ${EPS}

ps: ${PS}

pdf: ${PDF}

${PS}: ${MGP} ${EPS}
	mgp2ps ${MGP} > ${PS}

${PDF}: ${PS}
	ps2pdf ${PS}

${EPS}: %.eps: %.svg
	inkscape -z -E $@ $<

clean:
	-rm -f ${PS} ${PDF} ${ESP}
	-rm -f *~
