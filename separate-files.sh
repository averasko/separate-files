#!/bin/bash

if [ "$#" -ne 2 ]; then
    printf "The correct usage: dupe-finder <srcdir> <destdir>\n"
    printf "where <scrdir> - the directory to start search from recursively\n"
    printf "      <destdir> - the directory to MOVE dupes to\n"
else

srcdir=$1
destdir=$2

for filename in `find $1 -iname "*.nef"` ; do
    printf "$filename:"

    pathprefix="${filename%.*}"

    if [ -e "${pathprefix}.JPG" ]; then
        pathfrom="${pathprefix}.JPG" ;
    elif [ -e "${pathprefix}.jpg" ]; then
        pathfrom="${pathprefix}.jpg" ;
    fi

    if [ -n "$pathfrom" ]; then
        filefrom="${pathfrom##$srcdir}"
        pathto="$destdir/$filefrom"
        printf " moving $pathfrom to $pathto ... "
        relativedirectory="${pathto%/*.*}"
        mkdir -p "$relativedirectory" # making sure it exists
        mv "$pathfrom" "$pathto" && printf "done!"
    else 
        printf " no corresponding jpeg found."
    fi

    printf "\n"

    pathfrom=""

done

fi
