#!/bin/sh
#
# An example of test case.
#

name=$(basename $0 .sh)

#
# The file path for lsof executable.
#
lsof=$1

#
# Used only when a test case is failed.
# $report specifies a temporary file.
# Store how the test case is failed to the temporary file.
# The test harness uses this temporary file to make summary messages.
# The test harness removes this temporary file.
#
report=$2

# Return 0 means the case is run successfully.
exit 0
