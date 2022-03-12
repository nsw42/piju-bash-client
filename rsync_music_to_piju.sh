#!/bin/bash
# Usage:
#   no args: sync all new files
#   -s: Don't trigger a re-scan after rsync completes
#   -f: Force synchronising files - don't assume existing files are good
#   arg: subdir to restrict rsync

function usage() {
  echo Usage: $0 [-s] [subdir]
  exit 1
}

force=false
scan=true
while getopts fs arg; do
  case $arg in
    f)
      force=true
      ;;
    s) 
      scan=false
  esac
done

shift $(( OPTIND - 1 ))

if [ "$2" ]; then
  usage
fi

if [ "$1" ]; then
  ignore_existing=
  subdir="/$1"
else
  if $force; then
    ignore_existing=
  else
    ignore_existing=--ignore-existing
  fi
  subdir=
fi

ROOTDIR="/Users/Shared/iTunes Media/Music"
SRCDIR="$ROOTDIR$subdir/"
DSTDIR="music$subdir"
LOGFILE=rsync.log

if [ -f "$LOGFILE" ]; then
  rm $LOGFILE
fi

if [ '!' -d "$SRCDIR" ]; then
  echo $SRCDIR does not exist
  exit 1
fi

caffeinate rsync -rvts --exclude='.DS_Store' --delete --iconv=utf-8-mac,utf-8 --log-file=$LOGFILE --log-file-format='%f' $ignore_existing "$SRCDIR" "piju@piju:$DSTDIR"

# Trigger a rescan of each of the directories that has been updated by sending/deleting something

# Strip leading /
ROOTDIR=${ROOTDIR:1}

if $scan; then
  TMPFILE=rsync.tmp
  sed -E 's/^[0-9/]{10} [0-9:]{8} \[[0-9]*\] //' $LOGFILE | grep -v 'building file list' | grep -v 'sent [0-9,]* bytes  received [0-9,]* bytes' | grep -v 'total size is [0-9,]*  speedup' | grep -v '\.mp3$' | grep -v '\.jpg$' | sed 's/^deleting //' | sed "s_$ROOTDIR/__" | grep -v '^\.$' | sort > $TMPFILE

  exec 6< $TMPFILE
  previous=
  while read  -r -u 6 src; do
    if [[ -n "$previous" && $src =~ $previous/* ]]; then
      # echo "Skipping $src as a subdirectory of $previous"
      continue
    fi

    echo $src
    ./scan_dir.sh "$src"

    previous=$src
  done


  rm $TMPFILE
fi

rm $LOGFILE
