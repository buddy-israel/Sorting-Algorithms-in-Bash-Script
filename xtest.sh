#!/bin/bash

for (( i = 6; i > 0; i-- )); do

    case $i in
        5)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f randomIntegers.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with randomIntegers"


            echo "----------------------"
        ;;
        6)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f randomRealNumbers.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with randomRealNumbers"

            echo "----------------------"

        ;;
        *)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f randomRealNumbers0-1.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with randomRealNumbers0-1"

            echo "----------------------"

        ;;
    esac
done
