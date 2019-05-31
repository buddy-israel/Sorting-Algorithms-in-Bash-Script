#!/bin/bash

buildMaxHeap() {
    n=$1
    arr=("${@:2}")

    for (( i = 1; i < $n; i++ )); do

        if [[ 1 -eq `echo "${arr[$i]} > ${arr[$(( ( $i - 1 ) / 2 ))]}" | bc` ]]; then
            j=$i

            while [[ 1 -eq `echo "${arr[$j]} > ${arr[$(( ( $j - 1 ) / 2 ))]}" | bc` ]]; do

                tmp=${arr[j]}
                arr[j]=${arr[$(( ( $j - 1 ) / 2 ))]}
                arr[$(( ( $j - 1 ) / 2 ))]=$tmp

                (( j = ( $j - 1 ) / 2 ))
            done
        fi
    done

    echo "${arr[@]}"
}

heapSort() {

    arr=("${@:2}")
    n=${#arr[@]}

    arr=( $(buildMaxHeap $n "${arr[@]}") )

    for (( i = $(( $n - 1 )); i > 0; i-- )); do

        tmp=${arr[0]}
        arr[0]=${arr[i]}
        arr[i]=$tmp

        j=0
        index=0

        while :
        do

            (( index = 2 * $j + 1 ))

            if [[ $index -lt $(( $i - 1 )) && 1 -eq `echo "${arr[$index]} < ${arr[$(( $index + 1 ))]}" | bc` ]]; then
                (( index = $index + 1 ))
            fi

            if [[ $index -lt $i && 1 -eq `echo "${arr[$j]} < ${arr[$index]}" | bc` ]]; then
                tmp=${arr[j]}
                arr[j]=${arr[index]}
                arr[index]=$tmp
            fi

            j=$index

            if [[ $index -ge $i ]]; then
                break
            fi
        done
    done

    printf "%s\n" "${arr[@]}" > sorted.txt
}

arr=("${@:2}")
heapSort $1 "${arr[@]}"
