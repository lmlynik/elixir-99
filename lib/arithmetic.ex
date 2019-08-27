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

  def is_prime?(i) when is_integer(i) and i in [2, 3, 5, 7], do: true

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

      iex> Problem34.totient_phi(27)
      18
  """

  def totient_phi(i) do
    1..i
    |> Enum.filter(fn x -> Problem33.coprime?(x, i) end)
    |> Enum.count()
  end
end

defmodule Problem35 do
  @moduledoc """
  Construct a flat list containing the prime factors in ascending order.
  """

  @doc """
  ## Examples

      iex> Problem35.prime_factors(8)
      [2,2,2]
      iex> Problem35.prime_factors(315)
      [3,3,5,7]
  """

  def prime_factors(n), do: prime_factors(n, 2, [])

  def prime_factors(n, f, acc) when n < f, do: acc

  def prime_factors(n, f, acc) when rem(n, f) == 0, do: [f | prime_factors(div(n, f), f, acc)]

  def prime_factors(n, f, acc), do: prime_factors(n, f + 1, acc)
end

defmodule Problem36 do
  @moduledoc """
  Construct a list containing the prime factors and their multiplicity.

  """

  @doc """
  ## Examples

      iex> Problem36.prime_factors(8)
      [{2,3}]
      iex> Problem36.prime_factors(315)
      [{3,2},{5,1},{7,1}]
  """

  def prime_factors(n),
    do:
      prime_factors(n, 2, [])
      |> Problem10.pack()
      |> Enum.map(fn [h, s | _] ->
        {s, h}
      end)

  def prime_factors(n, f, acc) when n < f, do: acc

  def prime_factors(n, f, acc) when rem(n, f) == 0, do: [f | prime_factors(div(n, f), f, acc)]

  def prime_factors(n, f, acc), do: prime_factors(n, f + 1, acc)
end

defmodule Problem37 do
  @moduledoc """
  See problem P34 for the definition of Euler's totient function. If the list of the prime factors of a number m is known in the form of problem P36 then the function phi(m) can be efficiently calculated as follows: Let [[p1,m1],[p2,m2],[p3,m3],...] be the list of prime factors (and their multiplicities) of a given number m. Then phi(m) can be calculated with the following formula:
  phi(m) = (p1 - 1) * p1**(m1 - 1) * (p2 - 1) * p2**(m2 - 1) * (p3 - 1) * p3**(m3 - 1) * ...

  Note that a**b stands for the b'th power of a.
  """

  @doc """
  ## Examples

      iex> Problem37.totient_phi(10)
      Problem34.totient_phi(10)


      iex> Problem37.totient_phi(27)
      Problem34.totient_phi(27)
  """

  def totient_phi(n) do
    Problem36.prime_factors(n)
    |> Enum.map(fn {p, m} ->
      (p - 1) * :math.pow(p, m - 1)
    end)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
    |> round
  end
end

defmodule Problem39 do
  @moduledoc """
  Given a range of integers by its lower and upper limit, construct a list of all prime numbers in that range.
  """

  @doc """
  ## Examples

      iex> Problem39.primes(1, 10)
      [2,3,5,7]
  """

  def primes(from, to) do
    from..to
    |> Enum.filter(fn n -> Problem31.is_prime?(n) end)
  end
end

defmodule Problem40 do
  @moduledoc """
  Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers.
  Example: 28 = 5 + 23. It is one of the most famous facts in number theory that has not been proved to be correct in the general case.
  It has been numerically confirmed up to very large numbers (much larger than we can go with our Prolog system).
  Write a predicate to find the two prime numbers that sum up to a given even integer.

  """

  @doc """
  ## Examples
      iex> Problem40.goldbach(3)
      {:error, "not even"}

      iex> Problem40.goldbach(10)
      {:ok, {3, 7}}

      iex> Problem40.goldbach(28)
      {:ok, {5, 23}}

      iex> Problem40.goldbach(20)
      {:ok, {3, 17}}

      iex> Problem40.goldbach(1856)
      {:ok, {67, 1789}}

      iex> Problem40.goldbach(1001)
      {:error, "not even"}
  """

  def goldbach(n) when rem(n, 2) != 0, do: {:error, "not even"}

  def goldbach(n), do: goldbach(1, n - 1, n)

  defp goldbach(c, p, n) when c > 0 and p > 0 and p + c == n do
    case {Problem31.is_prime?(p), Problem31.is_prime?(c)} do
      {true, true} ->
        {:ok, {c, p}}

      _ ->
        goldbach(c + 1, p - 1, n)
    end
  end
end

defmodule Problem41 do
  @moduledoc """
  Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.
  Example:
  ?- goldbach_list(9,20).
  10 = 3 + 7
  12 = 5 + 7
  14 = 3 + 11
  16 = 3 + 13
  18 = 5 + 13
  20 = 3 + 17

  In most cases, if an even number is written as the sum of two prime numbers, one of them is very small. Very rarely, the primes are both bigger than say 50. Try to find out how many such cases there are in the range 2..3000.

  Example (for a print limit of 50):
  ?- goldbach_list(1,2000,50).
  992 = 73 + 919
  1382 = 61 + 1321
  1856 = 67 + 1789
  1928 = 61 + 1867

  """

  @doc """
  ## Examples
      iex> Problem41.goldbach_in_range(9, 20)
      [{10, 3, 7},{12, 5, 7}, {14, 3, 11}, {16, 3, 13}, {18, 5, 13}, {20, 3, 17}]
  """

  def goldbach_in_range(from, to) do
    from..to
    |> Enum.map(fn n -> {n, Problem40.goldbach(n)} end)
    |> Enum.filter(&match?({_, {:ok, _}}, &1))
    |> Enum.map(fn {n, {_, {p, c}}} -> {n, p, c} end)
  end
end

mox
