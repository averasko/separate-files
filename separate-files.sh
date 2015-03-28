#!/bin/bash

if [ "$#" -ne 2 ]; then
    printf "The correct usage: separate-files <srcdir> <destdir>\n"
    printf "where <scrdir> - the directory to start search from recursively\n"
    printf "      <destdir> - the directory to MOVE dupes to\n"
else

srcdir=$1
destdir=$2

# reading all the files to process
saveIFS="$IFS"; IFS=$'\n'; files=( $(find "$1" -iname "*.nef" -type f) ); IFS="$saveIFS"


for filename in "${files[@]}" ; do
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
