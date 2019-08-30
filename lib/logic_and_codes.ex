defmodule Predicates do
  @doc """
  ## Examples

      iex> Predicates.is_term(true)
      false

      iex> Predicates.is_term(:false)
      false

      iex> Predicates.is_term(:a)
      true

      iex> Predicates.is_term(:b)
      true

  """

  defguard is_term(v) when is_atom(v) and not is_boolean(v)
  defguard are_booleans(a, b) when is_boolean(a) and is_boolean(b)

  def and_(a, b), do: {:and, a, b}
  def or_(a, b), do: {:or, a, b}
  def eq_(a, b), do: {:eq, a, b}
  def xor_(a, b), do: {:xor, a, b}
  def nand_(a, b), do: {:nand, a, b}
  def impl_(a, b), do: {:impl, a, b}

  def not_(n), do: {:not, n}

  def a <~> b do
    and_(a, b)
  end

  def a <|> b do
    or_(a, b)
  end

  def a ^^^ b do
    eq_(a, b)
  end

  def eval(expr), do: eval(expr, %{})
  def eval({:and, a, b}, _) when are_booleans(a, b), do: a and b
  def eval({:or, a, b}, _) when are_booleans(a, b), do: a or b
  def eval({:eq, a, b}, _) when are_booleans(a, b), do: a == b
  def eval({:xor, a, b}, _) when are_booleans(a, b), do: !(a or b)
  def eval({:nand, a, b}, _) when are_booleans(a, b), do: !(a and b)
  def eval({:impl, a, b}, _) when are_booleans(a, b), do: !a or b
  def eval({:not, n}, _) when is_boolean(n), do: !n

  def eval({op, n}, map) when is_term(n), do: eval({op, map[n]}, map)

  def eval({op, a, b}, map) when is_term(a), do: eval({op, map[a], eval(b, map)}, map)
  def eval({op, a, b}, map) when is_term(b), do: eval({op, eval(a, map), map[b]}, map)

  def eval({op, a, b}, map), do: eval({op, eval(a, map), eval(b, map)}, map)

  def eval(t, map) when is_term(t), do: map[t]
  def eval(t, _) when not is_term(t), do: t
  def eval_values(expr, map), do: eval(expr, map)

  def table(terms, expr) do
    size = terms |> Enum.count()
    pow = :math.pow(2, size) |> round

    0..(pow - 1)
    |> Enum.map(fn n ->
      n
      |> Integer.digits(2)
      |> pad(size)
      |> truthy()
      |> zip(terms)
      |> Enum.into(%{})
      |> eval_terms(expr)
    end)
  end

  defp eval_terms(terms, expr) do
    Map.values(terms) ++ [Predicates.eval_values(expr, terms)]
  end

  defp zip(list1, list2), do: List.zip([list2, list1])

  defp pad(list, size) when length(list) < size do
    pad([0 | list], size)
  end

  defp pad(list, _), do: list

  defp truthy(list) do
    list
    |> Enum.map(fn
      0 -> false
      1 -> true
    end)
  end
end

defmodule Problem46 do
  @moduledoc """
  Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for logical equivalence) which succeed or fail according to the result of their respective operations;
  e.g. and(A,B) will succeed, if and only if both A and B succeed. Note that A and B can be Prolog goals (not only the constants true and fail).
  A logical expression in two variables can then be written in prefix notation, as in the following example: and(or(A,B),nand(A,B)).

  Now, write a predicate table/3 which prints the truth table of a given logical expression in two variables.
  """

  @doc """

  ## Examples
      iex> import Predicates
      ...> table([:a, :b], and_(:a, or_(:a, :b))) |> Enum.sort()
      [[true, true, true],[true, false, true], [false, true, false], [false, false, false]] |> Enum.sort()

  """

  def _() do
  end
end

defmodule Problem47 do
  @moduledoc """
  Continue problem P46 by defining and/2, or/2, etc as being operators. This allows to write the logical expression in the more natural way, as in the example: A and (A or not B). Define operator precedence as usual; i.e. as in Java.
  Example:
  ?- table(A,B, A and (A or not B)).
  true true true
  true fail true
  fail true fail
  fail fail fail
  """

  @doc """
  ## Examples

      iex> import Predicates
      ...> table([:a, :b], :a <~> (:a <|> not_(:b))) |> Enum.sort()
      [[true, true, true],[true, false, true], [false, true, false], [false, false, false]] |> Enum.sort()

  """
  def _() do
  end
end

defmodule Problem48 do
  @moduledoc """
  Generalize problem P47 in such a way that the logical expression may contain any number of logical variables. Define table/2 in a way that table(List,Expr) prints the truth table for the expression Expr, which contains the logical variables enumerated in List.
  Example:
  ?- table([A,B,C], A and (B or C) equ A and B or A and C).
  true true true true
  true true fail true
  true fail true true
  true fail fail true
  fail true true true
  fail true fail true
  fail fail true true
  fail fail fail true

  """

  @doc """
  ## Examples

      iex> import Predicates
      ...> table([:a, :b, :c], Problem48.expr1()) |> Enum.sort()
      Problem48.solution1() |> Enum.sort()

      iex> import Predicates
      ...> table([:a, :b, :c], Problem48.expr2()) |> Enum.sort()
      Problem48.solution2() |> Enum.sort()
  """

  import Predicates

  def expr1() do
    (:a <~> (:b <|> :c)) ^^^ (:a <~> :b <|> :a <~> :c)
  end

  def solution1() do
    [
      [true, true, true, true],
      [true, true, false, false],
      [true, false, true, true],
      [true, false, false, true],
      [false, true, true, true],
      [false, true, false, true],
      [false, false, true, true],
      [false, false, false, true]
    ]
  end

  def expr2() do
    :a <|> :b <|> :c
  end

  def solution2() do
    [
      [true, true, true, true],
      [true, true, false, true],
      [true, false, true, true],
      [true, false, false, true],
      [false, true, true, true],
      [false, true, false, true],
      [false, false, true, true],
      [false, false, false, false]
    ]
  end
end

defmodule Problem49 do
  @moduledoc """
  An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,
  n = 1: C(1) = ['0','1'].
  n = 2: C(2) = ['00','01','11','10'].
  n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].

  Find out the construction rules and write a predicate with the following specification:

  % gray(N,C) :- C is the N-bit Gray code

  Can you apply the method of "result caching" in order to make the predicate more efficient, when it is to be used repeatedly?

  """

  @doc """
  ## Examples

      iex> Problem49.gray(1)
      ['0', '1']

      iex> Problem49.gray(2)
      ['00','01','11','10']

      iex> Problem49.gray(3)
      ['000','001','011','010','110','111','101','100']

  """

  def gray(0), do: []
  def gray(1), do: ['0', '1']

  def gray(n) when is_integer(n) and n > 1 do
    lower = gray(n - 1)

    (lower |> Enum.map(fn l -> '0#{l}' end)) ++
      (lower |> Enum.reverse() |> Enum.map(fn l -> '1#{l}' end))
  end
end

defmodule Problem50 do
  @moduledoc """
  First of all, consult a good book on discrete mathematics or algorithms for a detailed description of Huffman codes!

  We suppose a set of symbols with their frequencies, given as a list of fr(S,F) terms. Example: [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)].
  Our objective is to construct a list hc(S,C) terms, where C is the Huffman code word for the symbol S.
  In our example, the result could be Hs = [hc(a,'0'), hc(b,'101'), hc(c,'100'), hc(d,'111'), hc(e,'1101'), hc(f,'1100')] [hc(a,'01'),...etc.].
  The task shall be performed by the predicate huffman/2 defined as follows:

  % huffman(Fs,Hs) :- Hs is the Huffman code table for the frequency table Fs
  """

  @doc """
  ## Examples

      iex> Problem50.huffman([{"a", 45}, {"b", 13}, {"c", 12}, {"d", 16}, {"e", 9}, {"f", 5}])
      [{"a","0"}, {"b","101"}, {"c","100"}, {"d","111"}, {"e","1101"}, {"f","1100"}]
  """

  defmodule Node do
    defstruct [:freq, :left, :right]
  end

  defmodule Leaf do
    defstruct [:freq, :char]
  end

  def huffman([]), do: []

  def huffman(ls) when is_list(ls) do
    tree =
      ls
      |> Enum.reduce(PairingHeap.new(), fn {l, f}, acc ->
        PairingHeap.put(acc, f, %Leaf{freq: f, char: l})
      end)
      |> huffmanTree()

    ls
    |> Enum.map(fn {l, _} -> l end)
    |> Enum.map(fn l -> {l, lookup(tree, l, "")} end)
  end

  defp huffmanTree(queue) do
    {pop1, xs} = PairingHeap.pop(queue)
    {pop2, xs2} = PairingHeap.pop(xs)
    {_, n1} = pop1
    {_, n2} = pop2

    huffmanTree(n1, n2, xs2)
  end

  defp huffmanTree(r, nil, _), do: r

  defp huffmanTree(n1, n2, xs) do
    nf = n1.freq + n2.freq

    xs
    |> PairingHeap.put(nf, %Node{freq: nf, left: n1, right: n2})
    |> huffmanTree()
  end

  defp lookup(%Node{left: leaf = %Leaf{}, right: node = %Node{}}, l, acc) do
    case leaf.char do
      ^l -> "#{acc}0"
      _ -> lookup(node, l, "#{acc}1")
    end
  end

  defp lookup(%Node{left: node = %Node{}, right: leaf = %Leaf{}}, l, acc) do
    case leaf.char do
      ^l -> "#{acc}1"
      _ -> lookup(node, l, "#{acc}0")
    end
  end

  defp lookup(%Node{left: node1 = %Node{}, right: node2 = %Node{}}, l, acc) do
    case {lookup(node1, l, "#{acc}0"), lookup(node2, l, "#{acc}1")} do
      {nil, r} -> r
      {r, nil} -> r
    end
  end

  defp lookup(%Node{left: leaf1 = %Leaf{}, right: leaf2 = %Leaf{}}, l, acc) do
    case {leaf1, leaf2} do
      {%Leaf{char: ^l}, _} -> "#{acc}0"
      {_, %Leaf{char: ^l}} -> "#{acc}1"
      _ -> nil
    end
  end
end
