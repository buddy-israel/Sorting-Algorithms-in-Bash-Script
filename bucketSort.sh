#!/bin/bash

bucketSort() {
    arr=("${@}")
    slotNum=10
    (( slot = $slotNum - 1 ))
    eval rm -rf tempFiles
    eval rm sorted.txt
    eval mkdir tempFiles
    eval touch tempFiles/file.{0..$slot}.txt

    for j in "${arr[@]}" ; do
        floatIndex=`echo "$j * $slotNum" | bc | awk '{printf "%f", $0}'`
        index=${floatIndex%.*}
        printf "%s\n" $j >> tempFiles/file.$index.txt
    done
    for (( i = 0; i < $slotNum; i++ )); do
        tempArray=()
        while IFS='' read -r line || [[ -n "$line" ]]; do
            tempArray+=( "$line" )
        done < "tempFiles/file.$i.txt"

        ./insertionSort.sh "${tempArray[@]}" > tempFiles/file.$i.txt &
        wait
    done
    eval touch sorted.txt
    for (( i = 0; i < $slotNum; i++ )); do
        cat tempFiles/file.$i.txt >> sorted.txt
    done
    eval rm -rf tempFiles
}

arr=("${@}")
bucketSort "${arr[@]}"
