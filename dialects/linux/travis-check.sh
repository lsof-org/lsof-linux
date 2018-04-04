#!/bin/sh -e
#
# Copyright 2018 Red Hat, Inc.
# Copyright 2018 Masatake YAMATO
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
make --version
export TRAVIS=1

echo
echo BUILDING LSOF
echo =============================================================================
./Configure -n linux
make -j4

echo
echo STARTING TEST
echo =============================================================================

nfailed=0
nsuccessful=0
nskipped=0
ncases=0
REPORTS=

for x in dialects/linux/tests/case-*.sh; do
    chmod a+x $x
    name=$(basename $x .sh)
    report=/tmp/$name-$$.report
    set +e
    ./$x $(pwd)/lsof $report
    s=$?
    set -e
    ncases=$((ncases + 1))
    if [ "$s" = 0 ]; then
	s=ok
	nsuccessful=$(($nsuccessful + 1))
	rm -f "$report"
    elif [ "$s" = 2 ]; then
	s=skipped
	nskipped=$((nskipped + 1))
	REPORTS="${REPORTS} ${report}"
    else
	s=failed
	nfailed=$((nfailed + 1))
	REPORTS="${REPORTS} ${report}"
    fi
    x=${x#case-}
    x=${x%.sh}
    printf "%50s %-10s\n"  $x $s
done

report()
{
    for r in "$@"; do
	echo
	echo $r
	echo -----------------------------------------------------------------------------
	cat $r
	rm $r
    done
}

echo
echo TEST SUMMARY
echo =============================================================================
printf "successful: %d\n" $nsuccessful
printf "skipped: %d\n" $nskipped
printf "failed: %d\n" $nfailed

if [ $nfailed = 0 ]; then
    printf "All %d test cases are passed successfully\n" $ncases
    if [ $nskipped = 0 ]; then
	:
    elif [ $nskipped = 1 ]; then
	printf "but 1 case is skipped\n"
	report $REPORTS
    else
	printf "but %d cases are skipped\n" $nskipped
	report $REPORTS
    fi
    exit 0
elif [ $nfailed = 1 ]; then
    printf "%d of %d case is failed\n" $nfailed $ncases
    report $REPORTS
    exit 1
else
    printf "%d of %d cases are failed\n" $nfailed $ncases
    report $REPORTS
    exit 1
fi
