using Base

# Non-mutating merge sort
function mergeSort(a)
    aCopy = copy(a)
    p = Threads.nthreads()
    n = length(a)
    type = eltype(a)

    if p < 2
        println("This algorithm requires 2 threads or more.")
        return nothing
    end

    parMergeSort(aCopy, 1, n, type)

    return aCopy
end

# Mutating merge sort
function mergeSort!(a)
    p = Threads.nthreads()
    n = length(a)
    type = eltype(a)

    if p < 2
        println("This algorithm requires 2 threads or more.")
        return nothing
    end

    parMergeSort(a, 1, n, type)

    return a
end

# parMergeSort uses the Spawn/Sync model to divide the work recursively.
# l = lower bound
# u = upper bound
function parMergeSort(a, l, u, type)

    if u - l < 1
        return nothing
    end
    
    # m = middle point
    m = div((l + u), 2)

    done = Threads.@spawn parMergeSort(a, l, m, type)
    parMergeSort(a, m+1, u, type)
    wait(done)

    merge(a, l, m, u, type)
end

function merge(a, l, m, u, type)
    n = u - l + 1
    b = Vector{type}(undef, n)
    # Current position in temp b vector
    pos = 1

    # Current positions in both sub-vectors
    pos1 = l
    pos2 = m+1

    while pos1 <= m && pos2 <= u
        if a[pos1] < a[pos2]
            b[pos] = a[pos1]
            pos1 += 1
        else
            b[pos] = a[pos2]
            pos2 += 1
        end
        pos += 1
    end

    while pos1 <= m
        b[pos] = a[pos1]
        pos1 += 1
        pos += 1
    end

    while pos2 <= u
        b[pos] = a[pos2]
        pos2 += 1
        pos += 1
    end

    a[l:u] = b
end
