#!/bin/sh

name=$(basename $0 .sh)
lsof=$1
report=$2
base=$(pwd)

(
    s=0
    f=/tmp/${name}-$$
    cd tests
    make opt > $f 2>&1

    if ! grep -q "LTbigf \.\.\. OK" $f; then
	echo '"LTbigf ... OK" is not found in the output' >> $report
	s=1
    fi

    # TODO: don't ignore "OK".
    if ! grep -q "LTdnlc \.\.\. .*/tests found: 100.00%" $f; then
	echo '"LTdnlc ... .*/tests found: 100.00%" is not found in the output' >> $report
	s=1
    fi

    if ! grep -q "LTlock \.\.\. OK" $f; then
	echo '"LTlock ... OK" is not found in the output' >> $report
	s=1
    fi

    # TODO: LTnfs

    if ! [ s = 0 ]; then
	echo
	echo "output"
	echo .............................................................................
	cat $f
    fi  >> $report
    rm $f

    exit $s
)
