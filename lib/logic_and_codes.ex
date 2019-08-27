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

  def eval({:and, a, b}) when are_booleans(a, b), do: a and b
  def eval({:or, a, b}) when are_booleans(a, b), do: a or b
  def eval({:eq, a, b}) when are_booleans(a, b), do: a == b
  def eval({:xor, a, b}) when are_booleans(a, b), do: !(a or b)
  def eval({:nand, a, b}) when are_booleans(a, b), do: !(a and b)
  def eval({:impl, a, b}) when are_booleans(a, b), do: !a or b

  def eval({op, a, b}) when is_term(a), do: eval({op, a, eval(b)})
  def eval({op, a, b}) when is_term(b), do: eval({op, eval(a), b})

  def eval({op, a, b}) when not is_term(a), do: eval({op, a, eval(b)})
  def eval({op, a, b}) when not is_term(b), do: eval({op, eval(a), b})

  def eval({op, a, b}), do: eval({op, eval(a), eval(b)})
  #  def eval(v, _) when not is_term(v) do
  #    v
  #  end
end

defmodule Problem46 do
end
