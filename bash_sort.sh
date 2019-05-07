#!/bin/bash

# awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > random.txt

declare -a arrToSort

printArray() {
    arr=("$@")

    for i in "${arr[@]}"; do
        echo "$i"
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

merge() {
	left=2
	(( right = $1 + 2 ))
	for i in ${@:2} ; do
		if [[ $left -eq $(( $1 + 2 )) ]] ; then
			echo ${@:$right:1}
            ((right += 1))
		else
			if [[ $right -eq $(( ${#@} + 1 )) ]] ; then
				echo ${@:$left:1}
                ((left += 1))
			else
				if (( $(echo "${@:$left:1} < ${@:$right:1}" | bc -l) )) ; then
					echo ${@:$left:1}
                    ((left += 1))
				else
					echo ${@:$right:1}
                    ((right += 1))
				fi
			fi
		fi
	done
}

mergeSort() {
    n=$1
	if [[ $n -ge 2 ]] ; then
		(( mid = $n / 2 ))
		left=( $(mergeSort $mid ${@:2:$mid}) )
		right=( $(mergeSort $(( $n - $mid )) ${@:$(( $mid + 2 )):$(( $n - $mid ))}) )
		echo "$(merge $mid ${left[@]} ${right[@]})"
	else
		echo $2
    fi
}



#
# max() {
#
#     m=$2
#     if [[ $3 -eq $1 && $(echo "${arrToSort[$3]} < ${arrToSort[$m]}" | bc -l) ]]; then
#         m=$3
#     fi
#     if [[ $4 -eq $1 && $(echo "${arrToSort[$4]} < ${arrToSort[$m]}" | bc -l) ]]; then
#         m=$4
#     fi
#     echo $m
# }
#
# downHeap() {
#
#     i=$2
#     while true ; do
#         j=$(max $1 $i $(( 2 * $i + 1 )) $(( 2 * $i + 2 )) )
#
#         if [[ $j -eq $i  ]]; then
#             break
#         fi
#         t=${arrToSort[$i]}
#         arrToSort[$i]=${arrToSort[$j]}
#         arrToSort[$j]=$t
#         i=$j
#
#     done
# }
#
# heapSortx() {
#     n=$1
#
#     for (( (( i = ($n - 2)/2 )); i >= 0; i-- )); do
#         downHeap $n $i
#     done
#
#     for (( i = 0; i < $n; i++ )); do
#         (( index = $n - $i - 1))
#         t=${arrToSort[$index]}
#         arrToSort[$index]=${arrToSort[1]}
#         arrToSort[1]=$t
#         downHeap $n $index
#     done
#
#     # printArray "${arr[@]}"
# }






#
# maxHeapify() {
#
#     arr="${@:3}"
#     local i=$1
#     (( L = 2 * i ))
#     (( R = 2 * i + 1 ))
#
#     largest=$i
#
#     if [[ $L -le $2 && $(echo "${arr[$L]} > ${arr[$i]}" | bc -l) ]]; then
#         largest=$L
#     fi
#
#     if [[ $R -le $2 && $(echo "${arr[$R]} > ${arr[$largest]}" | bc -l) ]]; then
#         largest=$L
#     fi
#     if [[ $largest -ne $i ]]; then
#
#         tmp=${arr[largest]}
#         arr[largest]=${arr[i]}
#         arr[i]=$tmp
#         arr=( $(maxHeapify $largest $2 "${arr[@]}") )
#     fi
#     echo "${arr[@]}"
# }
#
#
#
#
#
#
# buildMaxHeap() {
#
#     arr=("$@")
#     n=${#arr[@]}
#
#     local heapMaxIdx=$n
#
#     for (( i = (( heapMaxIdx/2 )); i >= 1; i-- )); do
#         echo "$(maxHeapify $i $heapMaxIdx "${arr[@]}")"
#     done
# }
#
#
# heapSort() {
#
#     arr=("$@")
#     n=${#arr[@]}
#
#     printArray "${arr[@]}"
#     echo "--------"
#
#     local heapMaxIdx=$n
#     local maxHeap=( $(buildMaxHeap "${arr[@]}") )
#
#     for (( i = $n; i > 1; i-- )); do
#
#         tmp=${arr[1]}
#         arr[1]=${arr[i]}
#         arr[i]=$tmp
#
#         (( heapMaxIdx-- ))
#         echo "$( maxHeapify 1 $heapMaxIdx "${maxHeap[@]}" )"
#     done
#     # printArray "${arr[@]}"
# }










# heapify() {  # $1 -> n  $2 -> i   $3 ...  -> arr
#     local i=$2
#     local arr=("${@:3}")
#     local n=${#arr[@]}
#
#     local largest=$i
#
#     local l=$(( (2 * $i) + 1 ))
#     local r=$(( (2 * $i) + 2 ))
#
#
#     if [[ $l -lt $n && $(echo "${arr[$i]} < ${arr[$l]}" | bc -l) ]]; then
#         largest=$l
#     fi
#
#     if [[ $r -lt $n && $(echo "${arr[$largest]} < ${arr[$r]}" | bc -l) ]]; then
#         largest=$r
#     fi
#
#     if [[ $largest -ne $i ]]; then
#         tmp=${arr[largest]}
#         arr[largest]=${arr[i]}
#         arr[i]=$tmp
#
#         arr=( $(heapify $n $largest "${arr[@]}") )
#     fi
#
#     echo "${arr[@]}"
# }
#
#
# heapSort() {
#
#     local arr=("$@")
#     local n=${#arr[@]}
#     printArray "${arr[@]}"
#
#     for (( i = $n; i >= 0; i-- )); do
#         arr=( $(heapify $n $i "${arr[@]}") )
#     done
#
#     echo "========="
#     printArray "${arr[@]}"
#     echo "========="
#
#     (( index = $n - 1 ))
#     for (( i = $index; i > 0; i-- )); do
#
#         tmp=${arr[0]}
#         arr[0]=${arr[i]}
#         arr[i]=$tmp
#
#         arr=( $(heapify $i 0 "${arr[@]}") )
#     done
#
#     printArray "${arr[@]}"
# }


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

    printArray "${arr[@]}"
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
                2) mergeSort $n "${numbersArray[@]}" > sortedRandom.txt ;;
                3) #arrToSort=${numbersArray[@]}
                   heapSort $n "${numbersArray[@]}" ;;
                   #printArray "${arrToSort[@]}" ;;
                4) quickSort "${numbersArray[@]}" ;;
                5) countingSort "${numbersArray[@]}" ;;
                6) bucketSort "${numbersArray[@]}" ;;
            esac
        fi
    fi
fi
