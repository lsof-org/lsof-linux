#!/bin/bash

pat=".*DIR[ \t]\+.*CLOX.*[ \t]\+.*/tmp$"
source $3/util-open-flags.sh "$@" "$pat" /tmp clox
