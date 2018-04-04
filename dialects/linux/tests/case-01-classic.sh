#!/bin/sh

name=$(basename $0 .sh)
lsof=$1
report=$2
base=$(pwd)

(
    f=/tmp/${name}-$$
    cd tests
    make > $f 2>&1

    if ! grep -q "LTbasic \.\.\. OK" $f; then
	echo '"LTbasic ... OK" is not found in the output' >> $report
	s=1
    fi

    if ! grep -q "LTnlink \.\.\. OK" $f; then
	echo '"LTnlink ... OK" is not found in the output' >> $report
	s=1
    fi

    if ! grep -q "LTsock \.\.\. OK" $f; then
	echo '"LTsock ... OK" is not found in the output' >> $report
	s=1
    fi

    if ! grep -q "LTszoff \.\.\. OK" $f; then
	echo '"LTszoff ... OK" is not found in the output' >> $report
	s=1
    fi

    if ! grep -q "LTunix \.\.\. OK" $f; then
	echo '"LTunix ... OK" is not found in the output' >> $report
	s=1
    fi

    if ! [ s = 0 ]; then
	echo >> $report
	cat $f >> $report
    fi
    rm $f

    exit $s
)
