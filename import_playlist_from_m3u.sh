#! /bin/bash

function usage() {
  echo Usage: $0 [-n] BASEMUSICDIR TITLE M3U [PLAYLISTID]
  echo Options:
  echo "  -n   Dry-run: just echo what would be done"
  echo "BASEMUSICDIR is the local, ie client, base path of all music files; paths of music files are computed relative to this directory, and must have the same relative location on the piju server (relative to the server music base directory)"
  echo "TITLE is the title of the playlist to create"
  echo "M3U is the .m3u or .m3u8 file to read"
  echo "PLAYLISTID, if specified, is the id of an existing playlist to replace"
}

source "$(dirname $0)/lib_piju_client.sh"

if [ "$1" = "-n" ]; then
  dryrun=true
  shift
else
  dryrun=false
fi

basedir=$1
title=$2
m3u=$3
playlistid=$4

if [ -z "$m3u" ]; then
  usage
  exit 1
fi

if [ "${basedir: -1}" != "/" ]; then
  basedir=$basedir/
fi

if [ "$playlistid" ]; then
  verb=PUT
else
  verb=POST
fi

declare -a command
command=(curl -X $verb -s "${CONTENT_TYPE[@]}" --data-binary @- "$PIJU_BASE_URL/playlists/$playlistid")
if $dryrun; then
  echo ${command[@]}
  command=(cat)
fi

(echo -n '{"title": "'$title'", "files": ['
 cat "$m3u" | tr '' '\n' | grep -v '^#' | grep -v '^$' | sed 's/"//' | sed "s:$basedir::" | awk '{print join "\"" $0 "\""; join=","}'; echo ']}') | "${command[@]}"
