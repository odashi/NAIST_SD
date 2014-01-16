#!/bin/sh

# $1: EPUB file path
EPUB=${1}

SCRIPTPATH=scripts
TEMPPATH=makegrasphy_temp

TOKENIZER=${SCRIPTPATH}/stanford-tokenizer
POSTAGGER=${SCRIPTPATH}/stanford-postagger
PARSER=${SCRIPTPATH}/stanford-parser-long
DEPENDENCY=${SCRIPTPATH}/stanford-dependency-long
SSPLITTER=${SCRIPTPATH}/sentence-boundary

# extract EPUB
unzip ${EPUB} -d ${TEMPPATH}
EXTRACTED=`ls ${TEMPPATH}`

# analyze
for filename in `find ${TEMPPATH} -name *.html`; do
	echo ""
	echo "========"
	echo ${filename}
	echo "========"
	echo ""
	python3 ${SCRIPTPATH}/extract_sentence.py ${filename} > ${filename}.sent
	${SSPLITTER} <${filename}.sent >${filename}.sent.split
	python3 ${SCRIPTPATH}/add_sentence_tag.py ${filename} > ${filename}.with_no

	${TOKENIZER} < ${filename}.sent.split > ${filename}.tok.split
	${POSTAGGER} < ${filename}.sent.split > ${filename}.pos.split
	${PARSER} < ${filename}.sent.split > ${filename}.parse
	${DEPENDENCY} < ${filename}.sent.split > ${filename}.dep.split
	
	python3 ${SCRIPTPATH}/remove_emptyline.py ${filename}.tok.split ${filename}.tok
	python3 ${SCRIPTPATH}/remove_emptyline.py ${filename}.pos.split ${filename}.pos
	python3 ${SCRIPTPATH}/concat_deps.py ${filename}.dep.split ${filename}.dep

	rm ${filename}.sent
	rm ${filename}.sent.split
	rm ${filename}.tok.split
	rm ${filename}.pos.split
	rm ${filename}.dep.split
done

# make EPUB for Grasphy
zip ${EPUB}.grasphy.epub ${TEMPPATH}/${EXTRACTED}

# dispose temporary data
rm -rf ${TEMPPATH}

