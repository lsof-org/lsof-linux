#!/bin/bash

pat=".*DIR[ \t]\+.*PATH.*[ \t]\+.*/tmp$"
source $3/util-open-flags.sh "$@" "$pat" /tmp path
