defmodule Problem1 do
  @moduledoc """
  Find the last element of a list.
  """

  @doc """
  Last

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
  Last

  ## Examples

      iex> Problem2.oneToLast([1,2,3,4])
      3

      iex> Problem2.oneToLast(['a','b','c','d'])
      'c'

      iex> Problem2.oneToLast([])
      nil

  """
  def oneToLast([]) do
    nil
  end

  def oneToLast(arr) do
    [_head | rest] = Enum.reverse(arr)
    List.first(rest)
  end
end

defmodule Problem3 do
  @moduledoc """
  Find the K'th element of a list.
  """

  @doc """
  Last

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
  Last

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
  Last

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
  Last

  ## Examples

      iex> Problem6.is_palindrome?([1,2,2,3,4])
      false

      iex> Problem6.is_palindrome?([1,2,3,2,1])
      true

      iex> Problem6.is_palindrome?([1,2,3,4,5,4,3,2,1])
      true

  """
  def is_palindrome?(arr) do
    t = arr |> Enum.count() |> div_2 |> Kernel.trunc()
    left = Enum.take(arr, t)
    right = arr |> Enum.reverse() |> Enum.take(t)
    left == right
  end

  defp div_2(n), do: n / 2
end

defmodule Problem7 do
  @moduledoc """
  Flatten a nested list structure
  """

  @doc """
  Last

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
  Last

  ## Examples

      iex> Problem8.compress(['a','a','b','b','a','c','c','c','d','d','d'])
      ['a','b','a','c','d']

      iex> Problem8.compress([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
      [1,2,1,3,2,4,2]

      iex> Problem8.compress([])
      []

  """
  def compress(arr) do
    compress(arr, []) |> Enum.reverse()
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
  Pack consecutive duplicates of list elements into sublists.
  """

  @doc """
  Last

  ## Examples

     #  iex> Problem9.pack(['a','a','b','b','a','c','c','c','d','d','d'])
     #  [['a','a'],['b','b'],['a'],['c','c','c'],['d','d','d']]

     #  iex> Problem9.pack([1, 1, 1, 2, 2, 1, 1, 3, 3, 3, 2, 4, 4, 4, 4 ,2])
     #  [[1,1,1],[2,2],[1,1],[3,3,3],[2],[4,4,4,4],[2]]

      iex> Problem9.pack([])
      []

  """
  def pack(arr) do
    pack(arr, [], []) |> Enum.reverse()
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
