# Python program for implementation of Quicksort

# This function is same in both iterative and recursive
def partition(arr,l,h):
    i = ( l - 1 )
    x = arr[h]

    print(arr)
    print("i:" + str(i))
    print("x:" + str(x))
    print("l:" + str(l))
    print("h:" + str(h))

    # print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
    for j in range(l , h):
        if   arr[j] <= x:

            # increment index of smaller element
            i = i+1
            arr[i],arr[j] = arr[j],arr[i]

    # print(arr)
    # print(i)

    arr[i+1],arr[h] = arr[h],arr[i+1]
    # print("-----")
    # print(arr)
    # print(i)
    # print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
    return (i+1)

# Function to do Quick sort
# arr[] --> Array to be sorted,
# l  --> Starting index,
# h  --> Ending index
def quickSortIterative(arr,l,h):

    # Create an auxiliary stack
    size = h - l + 1
    stack = [0] * (size)
    # initialize top of stack
    top = -1

    # push initial values of l and h to stack
    top = top + 1
    stack[top] = l
    top = top + 1
    stack[top] = h

    print("---------------")
    # Keep popping from stack while is not empty
    while top >= 0:
        print(arr)
        print("--------------------------------------------------")
        # print("----xxx----")
        # print("--------")
        #
        # print(h)
        # print(l)
        # print(top)
        # print("--------")

        # Pop h and l
        h = stack[top]
        top = top - 1
        l = stack[top]
        top = top - 1
        # print(h)
        # print(l)
        # print(top)
        # print("--------")
        # print("--------")

        # Set pivot element at its correct position in
        # sorted array
        p = partition( arr, l, h )
        print("------------------p-----------------")
        print(arr)
        print(p)

        print("---stack---top-----")
        print(stack)
        print(top)

        # If there are elements on left side of pivot,
        # then push left side to stack
        if p-1 > l:
            top = top + 1
            stack[top] = l
            top = top + 1
            stack[top] = p - 1

        print("---stack---top-----")
        print(stack)
        print(top)

        # If there are elements on right side of pivot,
        # then push right side to stack
        if p+1 < h:
            top = top + 1
            stack[top] = p + 1
            top = top + 1
            stack[top] = h

        print("---stack---top-----")
        print(stack)
        print(top)

# Driver code to test above
arr = [409.24,
252.04,
614.98,
374.17,
185.35,
833.71,
540.89,
506.33,
337.06,
553.38]
n = len(arr)
quickSortIterative(arr, 0, n-1)
print ("Sorted array is:")
print(arr)
