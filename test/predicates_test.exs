defmodule PredicatesTest do
  use ExUnit.Case

  import Predicates

  @moduletag :capture_log

  doctest Predicates

  test "module exists" do
    assert is_list(Predicates.module_info())
  end

  test "eval simple" do
    assert eval(and_(true, false)) == false
    assert eval(nand_(true, true)) == false
    assert eval(xor_(false, true)) == false
    assert eval(not_(true)) == false
  end

  test "structure" do
    assert and_(nand_(:a, :b), :b) == {:and, {:nand, :a, :b}, :b}
    assert or_(impl_(:a, :b), :b) == {:or, {:impl, :a, :b}, :b}
  end

  test "eval complex" do
    assert eval(or_(false, or_(true, false))) == true
  end

  test "eval values" do
    assert eval_values(or_(:a, or_(:b, :a)), %{a: false, b: true}) == true
  end
end
