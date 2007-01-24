
MGP=intro-to-git.mgp
PS=$(MGP:.mgp=.ps)
PDF=$(PS:.ps=.pdf)
SVG=$(wildcard *.svg)
EPS=$(SVG:.svg=.eps)

run: ${MGP} ${EPS}
	mgp -x vflib -g 1000x700 ${MGP}

ps: ${PS}

pdf: ${PDF}

${PS}: ${MGP} ${EPS}
	mgp2ps ${MGP} > ${PS}

${PDF}: ${PS}
	ps2pdf ${PS}

${EPS}: %.eps: %.svg
	inkscape -z -E $@ $<
