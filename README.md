# Naive-Merge-Sort

## A naive parallel implementation of the merge sort algorithm in Julia.

This solution is naive in the sense that only the recursive calls dividing the work in halves are done in parallel. The merge step is still done sequentially limiting the potential number of parallel tasks. The use of a temporary array in the merge step also leads to a lot of memory allocations.

The result is a solution that is much less time and memory efficient than the built in Julia sort functions. Still, it serves as a nice introduction to fork-join / spawn-sync parallel programming in Julia.

Both a non-mutating (mergeSort) and mutating (mergeSort!) version of the function is included.

---

## The Algorithm As Implemented:
### Inputs:
- Vector of elements 'a' of size 'n'

### Steps:
- **Step 1:** The parMergeSort function is called on the provided array.
- **Step 2:** parMergeSort calls itself recursively on two halves of the vector until it reaches sub-vectors with a single element.
- **Step 3:** The merge function is called on two sorted halves.

### Output:
- The sorted vector of elements
