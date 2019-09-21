defmodule Tree do
  defstruct [:value, :left, :right]

  def t(v) do
    %Tree{value: v, left: :end, right: :end}
  end
  def t(v, l) do
    %Tree{value: v, left: l, right: :end}
  end

  def t(v, l, r) do
    %Tree{value: v, left: l, right: r}
  end

  def balanced?(nil), do: true

  def balanced?(tree = %Tree{}) do
    left = tree.left == :end
    right = tree.right == :end
    (right && left) || (!right && !left)
  end

  def mirror?(nil, nil), do: true
  def mirror?(:end, :end), do: true
  def mirror?(:end, %Tree{}), do: false
  def mirror?(%Tree{}, :end), do: false

  def mirror?(left = %Tree{}, right = %Tree{}) do
    mirror?(left.left, right.right) && mirror?(left.right, right.left)
  end

  def add(:end, v) do
    %Tree{value: v, left: :end, right: :end}
  end

  def add(tree = %Tree{}, v) do
    case tree.value do
      value when v < value ->
        %Tree{value: tree.value, left: Tree.add(tree.left, v), right: tree.right}

      _ ->
        %Tree{value: tree.value, left: tree.left, right: Tree.add(tree.right, v)}
    end
  end

  def hbal_trees(1, v), do: [Tree.t(v)]
  def hbal_trees(height, _) when height < 1, do: [:end]
  def hbal_trees(height, value) do
    full_height = hbal_trees(height - 1, value)
    short = hbal_trees(height - 2, value)
    left = for l <- full_height,
        r <- full_height do
          Tree.t(l,r, value)
        end

    right = for f <- full_height,
                s <- short,
                r <- [Tree.t(f,s, value)],Tree.t(s,f, value)
                do
                  r
                end
    left ++ right
  end


end

defmodule Problem54 do
  @moduledoc """
  Check whether a given term represents a binary tree
  Write a predicate istree/1 which succeeds if and only if its argument is a Prolog term representing a binary tree.
  Example:
  ?- istree(t(a,t(b,nil,nil),nil)).
  Yes
  ?- istree(t(a,t(b,nil,nil))).
  No
  """

  @doc """

  ## Examples

      iex> Problem54.tree?(Tree.t(:a,Tree.t(:b,nil,nil),nil))
      true

      iex> Problem54.tree?(Tree.t(:a,Tree.t(:b,nil,nil)))
      false
  """

  def tree?(nil) do
    true
  end

  def tree?(root = %Tree{}) do
    Tree.balanced?(root) && Tree.balanced?(root.right) && Tree.balanced?(root.left)
  end
end

defmodule Problem55 do
  @moduledoc """
  In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

  Write a predicate cbal_tree/2 to construct completely balanced binary trees for a given number of nodes. The predicate should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.
  Example:
  ?- cbal_tree(4,T).
  T = t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))) ;
  T = t(x, t(x, nil, nil), t(x, t(x, nil, nil), nil)) ;
  etc......No
  """

  def cbal_tree(nodes, _) when is_integer(nodes) and nodes < 1, do: [:end]

  def cbal_tree(nodes, value) when is_integer(nodes) and rem(nodes, 2) == 1 do
    p = (nodes / 2) |> trunc
    sub_trees = cbal_tree(p, value)

    for l <- sub_trees,
        r <- sub_trees do
      %Tree{value: value, left: l, right: r}
    end
    |> List.flatten()
  end

  def cbal_tree(nodes, value) when is_integer(nodes) and rem(nodes, 2) == 0 do
    p = ((nodes - 1) / 2) |> trunc
    IO.inspect("#{nodes}: #{p}")
    lesser_trees = cbal_tree(p, value)
    greater_trees = cbal_tree(p + 1, value)

    for l <- lesser_trees,
        g <- greater_trees do
      [
        %Tree{value: value, left: l, right: g},
        %Tree{value: value, left: g, right: l}
      ]
    end
    |> List.flatten()
  end

  def cbal_tree(nodes, values) when is_float(nodes), do: cbal_tree(trunc(nodes), values)
end

defmodule Problem56 do
  @moduledoc """
    Let us call a binary tree symmetric if you can draw a vertical line through the root node and then the right subtree is the mirror image of the left subtree.
     Write a predicate symmetric/1 to check whether a given binary tree is symmetric. Hint: Write a predicate mirror/2 first to check whether one tree is the mirror image of another.
     We are only interested in the structure, not in the contents of the nodes.
  """
  @doc """

   ## Examples

   iex> Problem56.symetric?(Tree.t(:a,Tree.t(:b,nil,nil),Tree.t(:c,nil,nil)))
   true

   iex> Problem56.symetric?(Tree.t(:a,Tree.t(:b,nil,nil)))
   false

  """

  def symetric?(tree = %Tree{}) do
    Tree.mirror?(tree.left, tree.right)
  end
end

defmodule Problem58 do
  @moduledoc """
  Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes. Example:
  ?- sym_cbal_trees(5,Ts).
  Ts = [t(x, t(x, nil, t(x, nil, nil)), t(x, t(x, nil, nil), nil)), t(x, t(x, t(x, nil, nil), nil), t(x, nil, t(x, nil, nil)))]

  How many such trees are there with 57 nodes? Investigate about how many solutions there are for a given number of nodes?
  What if the number is even? Write an appropriate predicate.

  """

  def construct(n) do
    n
    |> Problem55.cbal_tree(:x)
    |> Enum.filter(fn f -> Problem56.symetric?(f) end)
  end
end
