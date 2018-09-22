#!/bin/sh

name=$(basename $0 .sh)
lsof=$1
report=$2
tdir=$3

MQUEUE_MNTPOINT=/tmp/$$

TARGET=$tdir/mq-open
if ! [ -x $TARGET ]; then
    echo "target execution ( $TARGET ) is not found" >> $report
    exit 1
fi

if grep -q mqueue /proc/mounts; then
    :
elif ! [ $(id -u) = 0 ]; then
    echo "root privileged is needed to run $(basename $0. sh)" >> $report
    exit 2
else
    mkdir -p ${MQUEUE_MNTPOINT}
    if ! mount -t mqueue none ${MQUEUE_MNTPOINT}; then
	echo "failed to mount mqeueu file system"
	exit 2
    fi
fi


cleanup()
{
    status=$1
    pid=$2

    kill $pid
    if [ -d ${MQUEUE_MNTPOINT} ]; then
	umount ${MQUEUE_MNTPOINT}
	rmdir ${MQUEUE_MNTPOINT}
    fi
    exit $status
}

$TARGET | {
    if read label0 pid sep label1 fd; then
	if line=`$lsof -p $pid -a -d $fd -Ft`; then
	    if echo "$line" | grep -q PSXMQ; then
		cleanup 0 $pid
	    else
		echo "unexpected output: $line" >> $report
		cleanup 1 $pid
	    fi
	else
	    echo "lsof rejects following command line: $lsof -p $pid -a -d $fd" >> $report
	    cleanup 1 $pid
	fi
    else
	echo "$TARGET prints an unexpected line: $label0 $pid $sep $label1 $fd" >> $report
	case "$pid" in
	    [0-9]*)
		kill $pid
		;;
	esac
	exit 1
    fi
}
