defmodule ElixirLearningTest do
  use ExUnit.Case
  doctest ElixirLearning

  test "greets the world" do
    assert ElixirLearning.hello() == :world
  end
end
