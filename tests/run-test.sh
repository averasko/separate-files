#!/bin/bash

# declaring the list of tests
declare -a testnames=("test1" "test2")
declare -a extraparams=("" "DNG png")


# iterating over test cases
i=0
for testname in "${testnames[@]}" ; do
  printf "Test: ${testname}\n"

  rm -rf tmp
  mkdir tmp
  cp -r "./${testname}/pre/" "./tmp/"
  eval "../separate-files.sh ./tmp/srcdir ./tmp/destdir ${extraparams[$i]} "
  diff -r "./${testname}/post" "./tmp" || { printf "${testname} FAILED!!!\n"; exit 1; }
  rm -rf tmp

  printf "$testname OK\n"

  i=$[$i +1]
done

printf "ALL OK\n"

