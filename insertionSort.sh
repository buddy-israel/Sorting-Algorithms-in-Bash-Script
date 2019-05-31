#!/bin/bash

arr=("$@")
n=${#arr[@]}

for((i=1;i<n;i++)) ; do
    j=$i-1
    temp=${arr[$i]}

    while [[ $j -ge 0 && 1 -eq `echo "${arr[$j]} > $temp" | bc` ]]; do
        arr[$j+1]=${arr[$j]}
        j=$((j-1))
    done
    arr[j+1]=$temp
done

printf "%s\n" "${arr[@]}"
