defmodule BeerSong do
  @two_bottle """
  2 bottles of beer on the wall, 2 bottles of beer.
  Take one down and pass it around, 1 bottle of beer on the wall.
  """
  @one_bottle """
  1 bottle of beer on the wall, 1 bottle of beer.
  Take it down and pass it around, no more bottles of beer on the wall.
  """
  @no_bottle """
  No more bottles of beer on the wall, no more bottles of beer.
  Go to the store and buy some more, 99 bottles of beer on the wall.
  """
  @doc """
  Gets a single verse of the beer song.
  """
  @spec verse(integer) :: String.t()
  def verse(number) when is_number(number) and not (number < 0) do
    track(number)
  end

  @doc """
  Gets the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0), do: Enum.map_join(range, "\n", &track/1)

  defp track(2), do: @two_bottle
  defp track(1), do: @one_bottle
  defp track(0), do: @no_bottle

  @spec track(integer) :: String.t()
  defp track(num_of_bottle) do
    """
    #{num_of_bottle} bottles of beer on the wall, #{num_of_bottle} bottles of beer.
    Take one down and pass it around, #{num_of_bottle - 1} bottles of beer on the wall.
    """
  end
end