defmodule ListSwap do

  @doc """
  The 'simple' solution, but a lot of Enum invoctations.
  Time complexity +- O(4n) ?
  """
  def naive_swap(list, pos_a, pos_b) do
    a = Enum.fetch!(list, pos_a)
    b = Enum.fetch!(list, pos_b)
    
    list
    |> List.replace_at(pos_a, b)
    |> List.replace_at(pos_b, a)
  end

  @doc """
  Splits the lists, never continues after where it isn't needed anymore.
  As we continue looking for `b` only in the part after `a`, this iterates the final list a lot less
  than the version above.

  Time complexity +- O(2n)?
  """
  def split_swap(list, pos_a, pos_a), do: list 
  def split_swap(list, pos_a, pos_b) when pos_a < pos_b do
    {initial, rest} = Enum.split(list, pos_a)
    {between, tail} = Enum.split(rest, pos_b - pos_a)
    a = hd(between)
    b = hd(tail)
    initial ++ [b] ++ tl(between) ++ [a] ++ tl(tail)
  end

  def split_swap(list, pos_a, pos_b) when pos_b < pos_a, do: split_swap(list, pos_b, pos_a)

  @doc """
  Idea by Ben Wilson: Convert to a map as it has NIF-powered element replacement.

  Time complexity +- O(3n + 3log(n))? 
  """
  def map_swap(list, pos_a, pos_b) do
    map = for {v, i} <- (list |> Enum.with_index), into: %{}, do: {i, v}
    a = map[pos_a]
    map
    |> put_in([pos_a], map[pos_b])
    |> put_in([pos_b], a)
    |> Map.values
  end

  @doc """
  Optimization of map_swap/3 by using plain recursion to build a map from a list.

  Time complexity +- O(2n + 3log(n))? 
  """
  def map_swap2(list, pos_a, pos_b) do
    map = 
      list
      |> list_to_indexed_map
    a = map[pos_a]
    map
    |> put_in([pos_a], map[pos_b])
    |> put_in([pos_b], a)
    |> Map.values
  end

  defp list_to_indexed_map(list) do
    list_to_indexed_map(list, 0, [])
  end

  defp list_to_indexed_map([], index, acc) do
    Map.new(acc)
  end

  defp list_to_indexed_map([head | tail], index, acc) do
    list_to_indexed_map(tail, index+1, [{index, head} | acc])
  end



  # defp list_to_indexed_map(list) do
  #   do_list_to_indexed_map(list, 0, %{})
  # end

  # defp do_list_to_indexed_map([], index, acc_map) do
  #   acc_map
  # end

  # defp do_list_to_indexed_map([head | tail], index, acc_map) do
  #   do_list_to_indexed_map(tail, index+1, Map.put(acc_map, index, head))
  # end
end
