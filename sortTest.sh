start_time="$(date -u +%s.%N)"
sort randomRealNumbers.txt
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for sort with randomRealNumbers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomRealNumbers.txt -a 1
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with randomRealNumbers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomRealNumbers.txt -a 2
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 2 with randomRealNumbers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomRealNumbers.txt -a 3
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 3 with randomRealNumbers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomRealNumbers.txt -a 4
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 4 with randomRealNumbers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomIntegers.txt -a 5
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 5 with randomIntegers.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f randomRealNumbers0-1.txt -a 6
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 6 with randomRealNumbers0-1.txt"
echo "-------------"
