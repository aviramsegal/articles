#!/bin/sh
cd $(dirname $0)
FILEPATH=$1
BASENAME=$(basename $FILEPATH)
DIR=$(dirname $FILEPATH)

BASENOEXT=${BASENAME%%.*}
FILENOEXT=${FILEPATH%%.*}
. $FILENOEXT.metadata


pandoc -t json "$FILEPATH" | \
./addCodeBlockMinipages | \
pandoc \
    -f json \
    --toc \
    --template pdf.latex \
    --latex-engine xelatex \
    --listings \
    --variable "graphics-path=${DIR}/" \
    --variable "linkcolor=black" \
    --variable "fontsize=12pt" \
    --variable "title=${TITLE}" \
    --variable "author=${AUTHOR}" \
    --variable "email=${EMAIL}" \
    -o ${BASENOEXT}.pdf