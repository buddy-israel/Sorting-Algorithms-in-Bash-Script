#!/bin/bash

partition() {

    l=$l
    h=$h
    arr=("${@:3}")
    (( i = $l - 1 ))
    x=${arr[$h]}

    for (( j = $l; j < $h; j++ )); do
        if [[ 1 -eq `echo "${arr[$j]} <= $x" | bc` ]]; then
            # increment index of smaller element
            ((i += 1))
            tmp=${arr[j]}
            arr[j]=${arr[i]}
            arr[i]=$tmp

        fi
    done
    tmp=${arr[h]}
    arr[h]=${arr[$(( $i + 1 ))]}
    arr[$(( $i + 1 ))]=$tmp
    ((i += 1))
    arr+=( $i )
    echo "${arr[@]}"
}

quickSort() {

    arr=("${@:2}")
    l=0
    (( h = $1 - 1 ))

    # Create an auxiliary stack
    (( size = $h - $l + 1 ))
    for (( i = 0; i < $size ; i++ )); do
        stack+=(0)
    done

    # initialize top of stack
    top=-1
    # push initial values of l and h to stack

    ((top += 1))
    stack[$top]=$l
    ((top += 1))
    stack[$top]=$h

    # Keep popping from stack while is not empty
    while(( $top>=0 )) ; do

        h=${stack[$top]}
        ((top -= 1))
        l=${stack[$top]}
        ((top -= 1))
        # Set pivot element at its correct position in
        # sorted array
        temp=( $( partition $l $h "${arr[@]}" ) )
        # echo "${temp[@]}"
        p=${temp[${#temp[@]}-1]}
        arr=( "${temp[@]:0:$size}" )
        # If there are elements on left side of pivot,
        # then push left side to stack
        if [[ $l -lt $(( $p - 1 )) ]]; then
            ((top += 1))
            stack[$top]=$l
            ((top += 1))
            stack[$top]=$(( $p - 1 ))
        fi
        # If there are elements on right side of pivot,
        # then push right side to stack
        if [[ $h -gt $(( $p + 1 )) ]]; then
            ((top += 1))
            stack[$top]=$(( $p + 1 ))
            ((top += 1))
            stack[$top]=$h
        fi
    done
    printf "%s\n" "${arr[@]}" > sorted.txt
}

arr=("${@:2}")
quickSort $1 "${arr[@]}"
