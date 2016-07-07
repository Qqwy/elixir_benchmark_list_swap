# ListSwap


This module contains four implementations of the `swap` function, that swaps two elements in a list.

### Naive Swap

    iex>ListSwap.naive_swap([1,2,3,4,5,6], 3, 5) 
    [1, 2, 6, 4, 5, 3]

This is a simple approach using `Enum.fetch!` and `List.keyreplace`. It is however not very fast.


### Split Swap
    iex>ListSwap.split_swap([1,2,3,4,5,6], 3, 5) 
    [1, 2, 6, 4, 5, 3]

This is an approach where the input list is split multiple times and combined in a different order.

### Map Swap

    iex>ListSwap.map_swap([1,2,3,4,5,6], 3, 5) 
    [1, 2, 6, 4, 5, 3]
    iex>ListSwap.map_swap2([1,2,3,4,5,6], 3, 5) 
    [1, 2, 6, 4, 5, 3]

These two approaches convert the list to an index-keyed map first, so we can harness the power of maps to do the replacement quicker. But converting the list to a map takes some time. The first one uses `Enum.into %{}` to do this, while the second one uses a custom recursion method and `Map.new` in an attempt to be more efficient.



## Execution of the Benchmark

    mix deps.get
    mix deps.compile
    mix bench

