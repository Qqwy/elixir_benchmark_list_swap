defmodule ListSwapBench do
  use Benchfella

  @list Enum.to_list(1..1000)

  for list_length <- [2, 10, 100, 1_000, 10_000] do
    @list_length list_length
    bench "naive_swap #{@list_length}" do
      ListSwap.naive_swap(Enum.to_list(1..@list_length), 1, div(@list_length,2))
    end

    bench "split_swap #{@list_length}" do
      ListSwap.split_swap(Enum.to_list(1..@list_length), 1, div(@list_length,2))
    end

    bench "map_swap #{@list_length}" do
      ListSwap.map_swap(Enum.to_list(1..@list_length), 1, div(@list_length,2))
    end

    bench "map_swap2 #{@list_length}" do
      ListSwap.map_swap2(Enum.to_list(1..@list_length), 1, div(@list_length,2))
    end
  end



end