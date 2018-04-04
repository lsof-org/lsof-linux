[![Build Status](https://travis-ci.org/masatake/lsof-linux.svg?branch=master)](https://travis-ci.org/masatake/lsof-linux)

# lsof-linux
UNOFFICIAL repository of linux part of lsof.

See "4.90" in ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/ChangeLog
about the reason why an unofficial repository is needed.

Three branches are maintained here:

* master
* bug-fixes
* devel

"master" is for tracking upstream.
"bug-fixes" collects unofficial patches fixing bugs.
"bug-fixes" is kept in sync with "master".
"devel" is an area for testing new features.

"EXCLUDE" file in this repository is passed to -X option of diff
command extract the latest changes in the the source tree released
from the upstream project.

"check-linux.sh" script in the "devel" is for testing lsof on trais-ci.
