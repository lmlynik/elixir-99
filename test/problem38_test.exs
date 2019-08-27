defmodule Problem38Test do
  use ExUnit.Case

  require TimeFrame

  test "module exists" do
    TimeFrame.execute "p34" do
      Problem34.totient_phi(10090)
    end

    TimeFrame.execute "p37" do
      Problem37.totient_phi(10090)
    end
  end
end
