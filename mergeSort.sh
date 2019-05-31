#!/bin/bash

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

arr=("${@:2}")
mergeSort $1 "${arr[@]}" > sorted.txt
