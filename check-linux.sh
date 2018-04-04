#!/bin/sh

os=${0##*check-}
os=${os%.sh}

if ! [ -d "dialects" -a -d "dialects/linux" ]; then
    echo '***' cannot find \"dialects\" directory.
    echo '***' you may be at a wrong directory.
fi 1>&2

./dialects/${os}/travis-check.sh $(pwd)/lsof
