#!/bin/bash

# awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > random.txt

printArray() {
    arr=("$@")

    for i in "${arr[@]}"; do
        echo "x $i"
    done
}

writeSortedArray() {
    arr=("$@")
    printf "%s\n" "${arr[@]}" > sortedRandom.txt
}

insertionSort() {

    arr=("$@")
    n=${#arr[@]}

    for((i=1;i<n;i++)) ; do
        j=$i-1
        temp=${arr[$i]}
        while(( $j>=0 && $(echo "${arr[$j]} > $temp" |bc -l) )) ; do  #arr[j]>temp
            arr[$j+1]=${arr[$j]}
            j=$((j-1))
        done
        arr[j+1]=$temp
    done

    writeSortedArray "${arr[@]}"
}

# merge() {
# 	left=2
# 	right=$(( $1 + 2 ))
# 	for i in ${@:2} ; do
# 		if [[ $left -eq $(( $1 + 2 )) ]] ; then
# 			echo ${@:$right:1} ; ((right += 1))
# 		else
# 			if [[ $right -eq $(( ${#@} + 1 )) ]] ; then
# 				echo ${@:$left:1} ; ((left += 1))
# 			else
# 				if (( $(echo "${@:$left:1} < ${@:$right:1}" | bc -l) )); then
# 					echo ${@:$left:1}
#                     ((left += 1))
# 				else
# 					echo ${@:$right:1}
#                     ((right += 1))
# 				fi
# 			fi
# 		fi
# 	done
# }
#
# mergeSort() {
#     # echo "1"
#     n=$1
# 	if [[ $n -ge 2 ]] ; then
#         # echo "2"
# 		middle=$(( $n / 2 ))
# 		left=( $(mergeSort $middle ${@:2:$middle}) )
#         # echo "3"
# 		right=( $(mergeSort $(( $n - $middle )) ${@:$(( $middle + 2 )):$(( $n - $middle ))}) )
#         # echo "4"
# 		echo "$(merge $middle ${left[@]} ${right[@]})"
#         # echo "5"
# 	else
#         # echo "6"
# 		echo $2
#     fi
#
#     # writeSortedArray ${@:2:(( $n + 1 ))}
# }

merge() { # $1 -> p   $2 -> q    $3 -> r  $4...n  -> arr

    n= $(( $# -3 ))

    p=$1
    q=$2
    r=$3

    arr= ${@:3:$n}

    echo "p = $p"
    echo "q = $q"
    echo "r = $r"

    echo "arr = $arr"

    # n1= $(( $q - $p + 1 ))
    # n2= $(( $r - $q ))
    #
    # for (( i = 1; i <= $n1; i++ )); do
    #     left[i]= ${arr[ $(( $p + $i  - 1 )) ]}
    # done
    #
    # for (( i = 1; i <= $n2; i++ )); do
    #     right[i]= ${arr[ $(( $q + $i )) ]}
    # done
}

mergeSort() {
    n= $(( $# - 2 ))
    echo $n
    if [[ $1 -lt $2 ]] ; then
        q=$(( ($1 + $2)/2 ))
        # mergeSort $1 $q ${@:3:$n}
        # mergeSort $(($q + 1) $2 ${@:3:$n}
        merge $1 $q $2 ${@:3:$n}
    fi
}

heapSort() {
    echo "heapSort"
}

quickSort() {
    echo "quickSort"
}

countingSort() {
    echo "countingSort"
}

bucketSort() {
    echo "bucketSort"
}

fun_read_array() {
    arr=("$@")
    for i in "${arr[@]}" ; do
        echo $i
    done
}

if [[ "$#" -ne 4 ]]; then
    if [[ ( "$#" -eq 1 )  && ( ( $1 = "-h" ) || ( $1 = "--help") ) ]] ; then
        echo "Help"
    else
        echo "Usage statement"
    fi
else
    # Check $1 is -f or --filename and $2 is exist and readable file.
    if [[ (( $1 = "-f" ) || ( $1 = "--filename")) && (-n $2 && -r $2) ]] ; then

        # Check 3 is -a or --algorithm and $4 is integer between 1 - 6
        if [[ (( $3 = "-a" ) || ( $3 = "--algorithm")) && ( "$4" =~ ^[1-6]$ ) ]] ; then

            # Add inputs to array
            while IFS='' read -r line || [[ -n "$line" ]]; do
                numbersArray+=( "$line" )
            done < "$2"

            n=${#numbersArray[@]}

            case $4 in
                1) insertionSort "${numbersArray[@]}" ;;
                2) mergeSort 1 $n "${numbersArray[@]}" ;;
                3) heapSort "${numbersArray[@]}" ;;
                4) quickSort "${numbersArray[@]}" ;;
                5) countingSort "${numbersArray[@]}" ;;
                6) bucketSort "${numbersArray[@]}" ;;
            esac
        fi
    fi
fi
