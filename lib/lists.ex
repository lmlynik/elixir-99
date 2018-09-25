defmodule Problem1 do
  @moduledoc """
  Find the last element of a list.
  """

  @doc """


  ## Examples

      iex> Problem1.last([1,2,3,4])
      4

      iex> Problem1.last(['a','b','c','d'])
      'd'

      iex> Problem1.last([])
      nil

  """
  def last(arr) do
    List.last(arr)
  end
end

defmodule Problem2 do
  @moduledoc """
  Find the last but one element of a list.
  """

  @doc """


  ## Examples

      iex> Problem2.oneTo([1,2,3,4])
      3

      iex> Problem2.oneTo(['a','b','c','d'])
      'c'

      iex> Problem2.oneTo([])
      nil

  """
  def oneTo([]) do
    nil
  end

  def oneTo(arr) do
    [_head | rest] = Enum.reverse(arr)
    List.first(rest)
  end
end

defmodule Problem3 do
  @moduledoc """
  Find the K'th element of a list.
  """

  @doc """


  ## Examples

      iex> Problem3.kthElement([1,2,3,4], 2)
      3

      iex> Problem3.kthElement(['a','b','c','d'], 3)
      'd'

      iex> Problem3.kthElement([], 4)
      nil

  """
  def kthElement(arr, k) do
    Enum.at(arr, k)
  end
end

defmodule Problem4 do
  @moduledoc """
  Find the number of elements of a list.
  """

  @doc """


  ## Examples

      iex> Problem4.findN([1,2,2,3,4], 2)
      2

      iex> Problem4.findN([1,1,2,1,1], 1)
      4

      iex> Problem4.findN(['a','b','c','d'], 3)
      0

      iex> Problem4.findN(['h','e','l','l','o'], 'l')
      2

      iex> Problem4.findN([], 4)
      0

  """
  def findN(arr, n) do
    findN(arr, n, 0)
  end

  defp findN([], _, acc) do
    acc
  end

  defp findN(arr, n, acc) do
    [head | tail] = arr
    inc = if head == n, do: 1, else: 0
    findN(tail, n, acc + inc)
  end
end

defmodule Problem5 do
  @moduledoc """
  Reverse a list
  """

  @doc """


  ## Examples

      iex> Problem5.reverse([1,2,2,3,4])
      [4,3,2,2,1]

  """
  def reverse(arr), do: Enum.reverse(arr)
end

defmodule Problem6 do
  @moduledoc """
  Find out whether a list is a palindrome.
  """

  @doc """


  ## Examples

      iex> Problem6.is_palindrome?([1,2,2,3,4])
      false

      iex> Problem6.is_palindrome?([1,2,3,2,1])
      true

      iex> Problem6.is_palindrome?([1,2,3,4,5,4,3,2,1])
      true

  """
  def is_palindrome?(arr) do
    t =
      arr
      |> Enum.count()
      |> div_2
      |> Kernel.trunc()

    left = Enum.take(arr, t)

    right =
      arr
      |> Enum.reverse()
      |> Enum.take(t)

    left == right
  end

  defp div_2(n), do: n / 2
end

defmodule Problem7 do
  @moduledoc """
  Flatten a nested list structure
  """

  @doc """


  ## Examples

      iex> Problem7.flatten([1,[2,1],[2,[3,4]]])
      [1,2,1,2,3,4]

  """
  def flatten(arr) do
    List.flatten(arr)
  end
end

defmodule Problem8 do
  @moduledoc """
  Eliminate consecutive duplicates of list elements.
  """

  @doc """


  ## Examples

      iex> Problem8.compress(['a','a','b','b','a','c','c','c','d','d','d'])
      ['a','b','a','c','d']

      iex> Problem8.compress([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [1,2,1,3,2,4,2]

      iex> Problem8.compress([])
      []

  """
  def compress(arr) do
    compress(arr, [])
    |> Enum.reverse()
  end

  defp compress([], acc), do: acc

  defp compress([head | tail], acc) do
    acc_last = List.first(acc)
    d_acc = if head == acc_last, do: acc, else: [head | acc]
    compress(tail, d_acc)
  end
end

defmodule Problem9 do
  @moduledoc """
  Pack consecutive duplicates of list elements into sub-lists.
  """

  @doc """


  ## Examples

      iex> Problem9.pack(['a','a','b','b','a','c','c','c','d','d','d'])
      [['a','a'],['b','b'],['a'],['c','c','c'],['d','d','d']]

      iex> Problem9.pack([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [[1,1,1],[2,2],[1,1],[3,3,3],[2],[4,4,4,4],[2]]

      iex> Problem9.pack([])
      []

  """
  def pack(arr) do
    pack(arr, [], [])
    |> Enum.reverse()
  end

  defp pack([], [], acc), do: acc

  defp pack([], group_acc, acc), do: [group_acc | acc]

  defp pack([head | tail], group_acc, acc) do
    case group_acc do
      [^head | _] -> pack(tail, [head | group_acc], acc)
      [] -> pack(tail, [head], acc)
      gr -> pack(tail, [head], [gr | acc])
    end
  end
end

defmodule Problem10 do
  @moduledoc """
  Use the result of problem P09 to implement the so-called run-length encoding data compression method. 
  Consecutive duplicates of elements are encoded as terms [N,E] where N is the number of duplicates of the element E.
  """

  @doc """


  ## Examples

      iex> Problem10.pack(['a','a','b','b','a','c','c','c','d','d','d'])
      [[2,'a'],[2,'b'],[1, 'a'],[3,'c'],[3,'d']]

      iex> Problem10.pack([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [[3,1],[2,2],[2,1],[3,3],[1, 2],[4,4],[1,2]]

      iex> Problem10.pack([])
      []

  """
  def pack(arr) do
    Problem9.pack(arr)
    |> Enum.map(&change_pack(&1))
  end

  defp change_pack(group), do: [Enum.count(group), List.first(group)]
end

defmodule Problem11 do
  @moduledoc """
  Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list. 
  Only elements with duplicates are transferred as [N,E] terms.
  """

  @doc """


  ## Examples

      iex> Problem11.pack(['a','a','b','b','a','c','c','c','d','d','d'])
      [[2,'a'],[2,'b'],'a',[3,'c'],[3,'d']]

      iex> Problem11.pack([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [[3,1],[2,2],[2,1],[3,3],2,[4,4],2]

      iex> Problem11.pack([])
      []

  """
  def pack(arr) do
    Problem9.pack(arr)
    |> Enum.map(&change_pack(&1))
  end

  defp change_pack([single | []]), do: single
  defp change_pack(group), do: [Enum.count(group), List.first(group)]
end

defmodule Problem12 do
  @moduledoc """
  Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
  """

  @doc """


  ## Examples

      iex> Problem12.unpack([[2,'a'],[2,'b'],'a',[3,'c'],[3,'d']])
      ['a','a','b','b','a','c','c','c','d','d','d']

      iex> Problem12.unpack([[3,1],[2,2],[2,1],[3,3],2,[4,4],2])
      [1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2]

      iex> Problem12.unpack([])
      []

  """
  def unpack(arr) do
    Enum.map(arr, &expand(&1))
    |> Enum.concat()
  end

  defp expand([c, el | []]) do
    Enum.map(1..c, fn _ -> el end)
  end

  defp expand(el), do: [el]
end

defmodule Problem13 do
  @moduledoc """
  Implement the so-called run-length encoding data compression method directly. 
  I.e. don't explicitly create the sublists containing the duplicates, as in problem P09, but only count them. As in problem P11,
  simplify the result list by replacing the singleton terms [1,X] by X.
  """

  @doc """


  ## Examples

      iex> Problem13.encode_direct(['a','a','b','b','a','c','c','c','d','d','d'])
      [[2,'a'],[2,'b'],'a',[3,'c'],[3,'d']]

      iex> Problem13.encode_direct([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [[3,1],[2,2],[2,1],[3,3],2,[4,4],2]

      iex> Problem13.encode_direct([])
      []

  """
  def encode_direct(arr) do
    count(arr, [])
    |> Enum.reverse()
    |> Enum.map(&change_pack(&1))
  end

  defp count([], acc), do: acc

  defp count([head | tail], acc) do
    dacc =
      case acc do
        [[c, ^head] | tacc] -> [[c + 1, head] | tacc]
        [[_, _] | _] -> [[1, head] | acc]
        [] -> [[1, head]]
      end

    count(tail, dacc)
  end

  defp change_pack([1, el]), do: el
  defp change_pack(group), do: group
end

defmodule Problem14 do
  @moduledoc """
  Duplicate the elements of a list.
  """

  @doc """


  ## Examples

      iex> Problem14.dupli(['a','b','c','c','d'])
      ['a','a','b','b','c','c','c','c','d','d']
      
      iex> Problem14.dupli([1,2,3,3,4,4,4])
      [1,1,2,2,3,3,3,3,4,4,4,4,4,4]

  """
  def dupli(arr) do
    Enum.map(arr, &dupl(&1))
    |> Enum.concat()
  end

  defp dupl(el), do: [el, el]
end

defmodule Problem15 do
  @moduledoc """
  Duplicate the elements of a list a given number of times.
  """

  @doc """


  ## Examples

      iex> Problem15.dupli(['a','b','c','c','d'],2)
      ['a','a','b','b','c','c','c','c','d','d']
      
      iex> Problem15.dupli([1,2,3,3,4,4,4],3)
      [1,1,1,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4]

      iex> Problem15.dupli([],3)
      []

      iex> Problem15.dupli([1],0)
      []

  """
  def dupli(arr, c) do
    Enum.map(arr, &dupl(&1, c))
    |> Enum.concat()
  end

  defp dupl(_, 0), do: []
  defp dupl(el, c), do: Enum.map(1..c, fn _ -> el end)
end

defmodule Problem16 do
  @moduledoc """
  Drop every N'th element from a list.
  """

  @doc """


  ## Examples

      iex> Problem16.drop(['a','b','c','c','d'],2)
      ['a','c','d']
      
      iex> Problem16.drop([1,2,3,3,4,4,4],3)
      [1,2,3,4,4]

      iex> Problem16.drop([],3)
      []

      iex> Problem16.drop([1],0)
      [1]

  """
  def drop(arr, 0), do: arr

  def drop(arr, dropEvery) do
    Enum.chunk_every(arr, dropEvery)
    |> Enum.map(fn chunk -> removeNth(chunk, dropEvery) end)
    |> Enum.concat()

    # drop(arr, [], dropEvery, dropEvery - 1) |> Enum.reverse()
  end

  defp removeNth(chunk, dropEvery) do
    case Enum.count(chunk) do
      ^dropEvery -> Enum.drop(chunk, -1)
      _ -> chunk
    end
  end
end

defmodule Problem17 do
  @moduledoc """
  Split a list into two parts; the length of the first part is given.
  """

  @doc """


  ## Examples

      iex> Problem17.split(['a','b','c','c','d'],2)
      [['a', 'b'], ['c', 'c', 'd']]
      
      iex> Problem17.split([1,2,3,3,4,4,4],3)
      [[1,2,3],[3,4,4,4]]

      iex> Problem17.split([],3)
      []

      iex> Problem17.split([1],0)
      [[],[1]]

  """
  def split([], _), do: []

  def split(arr, c) do
    {l, r} = Enum.split(arr, c)
    [l, r]
  end
end

defmodule Problem18 do
  @moduledoc """
  Given two indices, I and K, the slice is the list containing the elements between the I'th and K'th element of the original list (both limits included). 
  Start counting the elements with 1.
  """

  @doc """


  ## Examples

      iex> Problem18.slice(['a','b','c','d','e','f','g','h','i','k'],3,7)
      ['c','d','e','f','g']

  """

  def slice(arr, f, t) do
    Enum.slice(arr, f - 1, Enum.count(arr) - 1 - (t - f))
  end
end

defmodule Problem19 do
  @moduledoc """
  Rotate a list N places to the left.
  """

  @doc """


  ## Examples

      iex> Problem19.rotate(['a','b','c','d','e','f','g','h','i','k'],3)
      ['d','e','f','g','h','i','k','a','b','c']
      
      iex> Problem19.rotate(['a','b','c','d','e','f','g','h','i','k'],-3)
      ['h','i','k','a','b','c','d','e','f','g']

  """
  def rotate(arr, 0), do: arr

  def rotate([head | tail], c) when c > 0 do
    rotate(append(tail, head), c - 1)
  end

  def rotate(arr, c) when c < 0 do
    [head | tail] = Enum.reverse(arr)
    rotate(Enum.reverse(append(tail, head)), c + 1)
  end

  defp append(arr, el) do
    [el | Enum.reverse(arr)]
    |> Enum.reverse()
  end
end

defmodule Problem20 do
  @moduledoc """
  Remove the K'th element from a list.
  """

  @doc """


  ## Examples

      iex> Problem20.remove_at(['a','b','c','d'],2)
      ['a', 'b', 'd']
      
  """

  def remove_at(arr, at) do
    List.delete_at(arr, at)
  end
end

defmodule Problem21 do
  @moduledoc """
  Insert an element at a given position into a list.
  """

  @doc """


  ## Examples

      iex> Problem21.insert_at('alfa', ['a','b','c','d'], 1)
      ['a', 'alfa', 'b', 'c', 'd']

  """

  def insert_at(i, arr, at) do
    List.insert_at(arr, at, i)
  end
end

defmodule Problem22 do
  @moduledoc """
  Create a list containing all integers within a given range.
  """

  @doc """


  ## Examples

      iex> Problem22.range(4, 9)
      [4,5,6,7,8,9]

  """

  def range(from, to) do
    Enum.to_list(from..to)
  end
end

defmodule Problem23 do
  @moduledoc """
  Extract a given number of randomly selected elements from a list.
  """

  @doc """

  ## Examples
      iex> result = Problem23.rnd_select(['a','b','c','d','e','f','g','h'], 3)
      iex> Enum.count(result)
      3
      iex> Enum.dedup(result) |> Enum.count
      3
  """

  def rnd_select(arr, c) do
    i = Enum.random(arr)
    rnd_select(List.delete(arr, i), c - 1, [i])
  end

  defp rnd_select(_, 0, acc), do: acc

  defp rnd_select(arr, c, acc) do
    i = Enum.random(arr)
    rnd_select(List.delete(arr, i), c - 1, acc ++ [i])
  end
end

defmodule Problem24 do
  @moduledoc """
  Lotto: Draw N different random numbers from the set 1..M.
  """

  @doc """

  ## Examples
      iex> result = Problem24.rnd_select(6, 49)
      iex> Enum.count(result)
      6
  """

  def rnd_select(n, m) do
    Problem22.range(0, m)
    |> Problem23.rnd_select(n)
  end
end

defmodule Problem25 do
  @moduledoc """
  Generate a random permutation of the elements of a list.
  """

  @doc """

  ## Examples
      iex> result = Problem25.rnd_permu(['a','b','c','d','e','f'])
      iex> Enum.count(result)
      6
  """

  def rnd_permu(arr) do
    Enum.count(arr)
    |> (&Problem23.rnd_select(arr, &1)).()
  end
end

defmodule Problem28 do
  @moduledoc """
  a) We suppose that a list (InList) contains elements that are lists themselves. The objective is to sort the elements of InList according to their length. E.g. short lists first, longer lists later, or vice versa.

  Example:
  ?- lsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
  L = [[o], [d, e], [d, e], [m, n], [a, b, c], [f, g, h], [i, j, k, l]]

  b) Again, we suppose that a list (InList) contains elements that are lists themselves. But this time the objective is to sort the elements of InList according to their length frequency; i.e. in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.

  Example:
  ?- lfsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
  L = [[i, j, k, l], [o], [a, b, c], [f, g, h], [d, e], [d, e], [m, n]]

  Note that in the above example, the first two lists in the result L have length 4 and 1, both lengths appear just once. The third and forth list have length 3 which appears, there are two list of this length. And finally, the last three lists have length 2. This is the most frequent length.
  """

  @doc """

  ## Examples
      iex> Problem28.lsort([['a','b','c'],['d','e'],['f','g','h'],['d','e'],['i','j','k','l'],['m','n'],['o']])
      [['o'], ['d', 'e'], ['d', 'e'], ['m', 'n'], ['a', 'b', 'c'], ['f', 'g', 'h'], ['i', 'j', 'k', 'l']]

      iex> Problem28.lfsort([['a','b','c'],['d','e'],['f','g','h'],['d','e'],['i','j','k','l'],['m','n'],['o']])
      [['o'], ['i', 'j', 'k', 'l'], ['a', 'b', 'c'], ['f', 'g', 'h'], ['d', 'e'], ['d', 'e'], ['m', 'n']]
  """

  def lsort(arr) do
    arr
    |> Enum.sort(fn l, r -> Enum.count(l) <= Enum.count(r) end)
  end

  def lfsort(arr) do
    arr
    |> Enum.group_by(fn l -> Enum.count(l) end)
    |> Enum.map(fn {_, v} -> {Enum.count(v), v} end)
    |> Enum.sort(fn {c1, _}, {c2, _} -> c1 <= c2 end)
    |> Enum.flat_map(fn {_, l} -> l end)
  end
end
