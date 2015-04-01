#!/bin/bash

if [ "$#" -lt 2 ] || [ "$#" -gt 4 ] ; then
    printf "Moves all files with extension <moveext> from <srcdir> to <destdir> for which there is a file with the same name and <baseext> extension recursively. Folder structure is preserved.\n"
    printf "Usage: separate-files <srcdir> <destdir> [<baseext>] [<moveext>]\n"
    printf "where <scrdir> - the directory to start search from\n"
    printf "      <destdir> - the directory to MOVE dupes to\n"
    printf "      <baseext> - the extension of filesto keep in place (NEF by default)\n"
    printf "      <moveext> - the extension of files to move (JPG by default)\n"
    printf "ex: separate-files ~/photos ~/photo-dupes NEF JPG <-- moves all jpegs that have corresponding NEFs from photos to photo-dupes for, supposedly, further processing or deleting.\n"
else

srcdir=$1
destdir=$2
baseext=NEF
moveext=JPG

# setting the extensions if provided
if [ "$#" -ge 3 ] ; then
    baseext=$3
fi

if [ "$#" -ge 4 ] ; then
    moveext=$4
fi


# reading all the files to process
saveIFS="$IFS"; IFS=$'\n'; files=( $(find "$1" -iname "*.$baseext" -type f) ); IFS="$saveIFS"


# for each file in <srcdir>
for filename in "${files[@]}" ; do
    printf "$filename:"

    # resetting the variable for each iteration
    pathfrom=""

    pathprefix="${filename%.*}"

    if [ -e "${pathprefix}.$moveext" ]; then
        pathfrom="${pathprefix}.$moveext" ;
    fi

    if [ -n "$pathfrom" ]; then
        filefrom="${pathfrom##$srcdir}"
        pathto="$destdir/$filefrom"
        printf " $pathfrom -> $pathto ..."
        relativedirectory="${pathto%/*.*}"
        mkdir -p "$relativedirectory" # making sure the target directory exists
        mv "$pathfrom" "$pathto" && printf " done!"
    else 
        printf " no corresponding $pathfrom file."
    fi

    printf "\n"

done

fi
