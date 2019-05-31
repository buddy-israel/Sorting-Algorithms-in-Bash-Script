awk -v n=200 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > RealNumber_200.txt
awk -v n=200 -v max=1000 'BEGIN{srand(); for (i=0; i<n; ++i) print int(rand()*(max+1))}' > Integer_200.txt
awk -v n=200 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.4f\n", rand()) }' > RealNumber_0-1_200.txt


start_time="$(date -u +%s.%N)"
sort RealNumber_200.txt
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for sort with RealNumber_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_200.txt -a 1
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_200.txt -a 2
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 2 with RealNumber_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_200.txt -a 3
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 3 with RealNumber_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_200.txt -a 4
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 4 with RealNumber_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f Integer_200.txt -a 5
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 5 with Integer_200.txt"
echo "-------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_0-1_200.txt -a 6
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 6 with RealNumber_0-1_200.txt"
echo "-------------"
