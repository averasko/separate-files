#!/bin/bash

# Testing the script

rm -fr tmp
mkdir tmp
cp -r ./pre/* ./tmp/
../separate-files.sh ./tmp/srcdir ./tmp/destdir
diff -r ./post ./tmp || { printf "TEST FAILED!!!\n"; exit 1; }
printf "TEST OK\n"

