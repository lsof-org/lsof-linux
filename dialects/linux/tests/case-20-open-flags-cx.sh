#!/bin/bash

pat=".*DIR[ \t]\+.*CX.*[ \t]\+.*/tmp$"
source $3/util-open-flags.sh "$@" "$pat" /tmp cx
