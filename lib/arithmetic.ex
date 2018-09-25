defmodule Problem31 do
  @moduledoc """
  Determine whether a given integer number is prime.
  """

  @doc """


  ## Examples

      iex> Problem31.is_prime?(7)
      true
      iex> Problem31.is_prime?(9)
      false
      iex> Problem31.is_prime?(8191)
      true

  """

  def is_prime?(i) when is_integer(i) and i < 2, do: false

  def is_prime?(i) when is_integer(i) and i > 2, do: is_prime?(2, i)

  defp is_prime?(x, x), do: true

  defp is_prime?(c, i) when rem(i, c) != 0, do: is_prime?(c + 1, i)

  defp is_prime?(_, _), do: false
end

defmodule Problem32 do
  @moduledoc """
  Determine the greatest common divisor of two positive integer numbers.
  """

  @doc """

  ## Examples

      iex> Problem32.gcd(36, 63)
      9
      iex> Problem32.gcd(81, 9)
      9
      iex> Problem32.gcd(123, 321)
      3
      iex> Problem32.gcd(35, 64)
      1
  """

  def gcd(x, 0), do: x

  def gcd(a, b) do
    gcd(b, rem(a, b))
  end
end

defmodule Problem33 do
  @moduledoc """
  Two numbers are coprime if their greatest common divisor equals 1.
  """

  @doc """

  ## Examples

      iex> Problem33.coprime?(35, 64)
      true
  """

  def coprime?(a, b) do
    Problem32.gcd(a, b) == 1
  end
end

defmodule Problem34 do
  @moduledoc """
  Euler's so-called totient function phi(m) is defined as the number of positive integers r (1 <= r < m) that are coprime to m.
  """

  @doc """

  ## Examples

      iex> Problem34.totient_phi(10)
      4
  """

  def totient_phi(i) do
    1..i
    |> Enum.filter(fn x -> Problem33.coprime?(x, i) end)
    |> Enum.count()
  end
end