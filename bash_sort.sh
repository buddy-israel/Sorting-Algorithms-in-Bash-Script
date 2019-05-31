#!/bin/bash

# awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > randomRealNumbers.txt
# awk -v n=20 -v max=100 'BEGIN{srand(); for (i=0; i<n; ++i) print int(rand()*(max+1))}' > randomIntegers.txt
# awk -v n=20 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.4f\n", rand()) }' > randomRealNumbers0-1.txt

printArray() {
    arr=("$@")

    for i in "${arr[@]}"; do
        echo "$i"
    done
}

#===============================================================================

printUsageStatement() {

    echo "  ./bash_sort: missing argument.
        Usage: ./bash_sort –f | --filename <input filename> -a | --algorithm <sorting algorithm> [-h | --help]
        Try './bash_sort --help' for more information."
}

printUsageStatement2() {

    echo "  ./bash_sort: wrong argument or missing file.
        Usage: ./bash_sort –f | --filename <input filename> -a | --algorithm <sorting algorithm> [-h | --help]
        Try './bash_sort --help' for more information."
}

#===============================================================================

if [[ "$#" -ne 4 ]]; then
    if [[ ( "$#" -eq 1 )  && ( ( $1 = "-h" ) || ( $1 = "--help") ) ]] ; then
        cat help.txt
    else
        printUsageStatement
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
                1) ./insertionSort.sh "${numbersArray[@]}" > sorted.txt ;;
                2) ./mergeSort.sh $n "${numbersArray[@]}" > sorted.txt ;;
                3) ./heapSort.sh $n "${numbersArray[@]}" ;;
                4) ./quickSort.sh $n "${numbersArray[@]}" ;;
                5) ./countingSort.sh $n "${numbersArray[@]}" ;;
                6) ./bucketSort.sh "${numbersArray[@]}" ;;
            esac
        else
            printUsageStatement2
        fi
    else
        printUsageStatement2
    fi
fi
