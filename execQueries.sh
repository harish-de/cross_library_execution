#!/bin/bash

queries=(1,3,4,6)

for q in ${queries[@]};
do
  ./cross_library_execution $q
done

