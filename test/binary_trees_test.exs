defmodule BinaryTreeProblemsTest do
  use ExUnit.Case
  doctest Problem54
  doctest Problem55
  doctest Problem56

  test "Problem 55" do
    expected = [
      %Tree{
        left: %Tree{left: :end, right: :end, value: "x"},
        right: %Tree{
          left: :end,
          right: %Tree{left: :end, right: :end, value: "x"},
          value: "x"
        },
        value: "x"
      },
      %Tree{
        left: %Tree{
          left: :end,
          right: %Tree{left: :end, right: :end, value: "x"},
          value: "x"
        },
        right: %Tree{left: :end, right: :end, value: "x"},
        value: "x"
      },
      %Tree{
        left: %Tree{left: :end, right: :end, value: "x"},
        right: %Tree{
          left: %Tree{left: :end, right: :end, value: "x"},
          right: :end,
          value: "x"
        },
        value: "x"
      },
      %Tree{
        left: %Tree{
          left: %Tree{left: :end, right: :end, value: "x"},
          right: :end,
          value: "x"
        },
        right: %Tree{left: :end, right: :end, value: "x"},
        value: "x"
      }
    ]

    assert Problem55.cbal_tree(4, "x") == expected
  end

  test "Problem 57" do
    res = Tree.add(:end, 2)
    assert res == %Tree{left: :end, right: :end, value: 2}
    res1 = res |> Tree.add(3)
    res2 = res1 |> Tree.add(0)

    assert res2 == %Tree{
             left: %Tree{left: :end, right: :end, value: 0},
             right: %Tree{left: :end, right: :end, value: 3},
             value: 2
           }
  end

  test "Problem 58 - 5 nodes" do
    expected = [
      %Tree{
        left: %Tree{
          left: :end,
          right: %Tree{left: :end, right: :end, value: :x},
          value: :x
        },
        right: %Tree{
          left: %Tree{left: :end, right: :end, value: :x},
          right: :end,
          value: :x
        },
        value: :x
      },
      %Tree{
        left: %Tree{
          left: %Tree{left: :end, right: :end, value: :x},
          right: :end,
          value: :x
        },
        right: %Tree{
          left: :end,
          right: %Tree{left: :end, right: :end, value: :x},
          value: :x
        },
        value: :x
      }
    ]

    assert Problem58.construct(5)
           |> Enum.filter(fn f -> Problem56.symetric?(f) end) == expected
  end

  test "Problem 58 - 7 nodes" do
    expected = [
      %Tree{
        left: %Tree{
          left: %Tree{left: :end, right: :end, value: :x},
          right: %Tree{left: :end, right: :end, value: :x},
          value: :x
        },
        right: %Tree{
          left: %Tree{left: :end, right: :end, value: :x},
          right: %Tree{left: :end, right: :end, value: :x},
          value: :x
        },
        value: :x
      }
    ]

    assert Problem58.construct(7)
           |> Enum.filter(fn f -> Problem56.symetric?(f) end) == expected
  end

  test "Problem 58 - 57 nodes" do
    assert Problem58.construct(57) |> length == 256
  end

  test "Problem 59" do
    assert Tree.hbal_trees(4, :x) == :a
  end
end
