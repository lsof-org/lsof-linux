[![Build Status](https://travis-ci.org/lsof-org/lsof-linux.svg?branch=devel)](https://travis-ci.org/lsof-org/lsof-linux)
[![Coverage Status](https://coveralls.io/repos/github/lsof-org/lsof-linux/badge.svg?branch=devel)](https://coveralls.io/github/lsof-org/lsof-linux?branch=devel)

# lsof-linux
The official but temporary repository of linux part of lsof.

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
command for extracting the latest changes in the the source tree
released from the upstream project.

"check-linux.sh" script in the "devel" branch is for testing lsof on
travis-ci.

We will start lsof5 repository that deals multiple dialects at
least linux and freebsd. The result of development at this
repository will be merge to the lsof5 repository when the
repository becomes ready.
