defmodule Roman do
  @moduledoc """
  Provides the function, to convert number into roman number.

  ## Example

      iex> Roman.numerals(6) 
      "VI"
  """
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    to_roman(number, "")
  end

  
  @spec to_roman(pos_integer, String.t()) :: String.t()
  defp to_roman(number, rom_num) when number > 0 do
    {largest_base, symbol} = num_range(number)
    rom_num = rom_num <> String.duplicate(symbol, div(number, largest_base))
    to_roman(rem(number, largest_base), rom_num)
  end

  
  defp to_roman(0, rom_num) do
    rom_num
  end

  
  @spec num_range(pos_integer) :: {pos_integer, String.t()}
  defp num_range(number) do
    case number do
      number when number >= 1000 -> {1000, "M"}
      number when number >= 900 -> {900, "CM"}
      number when number >= 500 -> {500, "D"}
      number when number >= 400 -> {400, "CD"}
      number when number >= 100 -> {100, "C"}
      number when number >= 90 -> {90, "XC"}
      number when number >= 50 -> {50, "L"}
      number when number >= 40 -> {40, "XL"}
      number when number >= 10 -> {10, "X"}
      number when number >= 9 -> {9, "IX"}
      number when number >= 5 -> {5, "V"}
      number when number >= 4 -> {4, "IV"}
      number when number < 4 and number > 0 -> {1, "I"}
    end
  end
end