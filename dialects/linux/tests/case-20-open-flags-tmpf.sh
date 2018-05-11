#!/bin/bash

pat=".*REG[ \t]\+.*TMPF.*/tmp/.*$"
source $3/util-open-flags.sh "$@" "$pat" /tmp tmpf rdwr
