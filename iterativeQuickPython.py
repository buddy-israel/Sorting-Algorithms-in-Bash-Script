def counting_sort(array, maxval):
    """in-place counting sort"""
    n = len(array)
    m = maxval + 1
    count = [0] * m               # init with zeros
    for a in array:
        count[a] += 1             # count occurences

    i = 0
    for a in range(m):            # emit
        for c in range(count[a]): # - emit 'count[a]' copies of 'a'
            # print(a)
            array[i] = a
            i += 1
        # print("-------------")
    return array
# arr = [92, 97, 68, 49, 44, 58, 81, 55, 64, 52, 48, 41, 69, 66, 39, 38, 23, 71, 52, 71]
arr = [67, 66, 85, 46, 49, 15, 32, 64, 92, 72, 50, 8, 27, 5, 44, 36, 30, 17, 78, 40, 76, 97, 44, 99, 17, 1, 16, 74, 79, 76, 48, 45, 41, 33, 91, 90, 48, 23, 54, 39, 96, 4, 48, 22, 9, 93, 59, 40, 9, 36, 80, 85, 32, 24, 84, 50, 25, 0, 23, 3, 76, 72, 48, 17, 4, 39, 6, 53, 62, 61, 92, 57, 65, 40, 80, 75, 33, 38, 14, 42, 75, 94, 27, 7, 17, 10, 57, 42, 10, 81, 46, 87, 52, 95, 3, 56, 33, 10, 9, 96]
print(counting_sort( arr, 100 ))
