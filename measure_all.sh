#!/bin/bash
for (( i =0; i <= 10; i++ ))
do
        ./cross_library_execution $((i*10))
        printf ' \n '
done
