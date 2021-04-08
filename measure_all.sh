#!/bin/bash
for (( i =32; i <= 268435456; i*=2 ))
do
        printf $i
        printf ' \t '
        ./select-baseline $i
        printf ' \t '
        ./select-tensor-chunking-newapproach $i
        printf ' \n '
done
