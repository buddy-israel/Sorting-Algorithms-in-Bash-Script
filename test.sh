start_time="$(date -u +%s.%N)"
bash_sort -f randomRealNumbers.txt -a 1
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for -a with 10,000 numbers"
