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

    writeSortedArray "${arr[@]}"
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
