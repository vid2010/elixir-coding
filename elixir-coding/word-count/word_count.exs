defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @doc """
  Retuns a map, count the occurrences of each word in that sentence.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      |> split_sentence
      |> Enum.reduce(%{}, &map_count/2)
  end

  @doc """
  Retuns a count of each word in that sentence and updates count into map word-count map.
  """
  @spec map_count([String.t()], map) :: Number
  defp count_map([x], acc) do
    Map.update(acc, x, 1, &(&1+1))
  end

  @doc """
  Split the sentence into the list of world list.
  """
  @spec split_sentence(String.t()) :: [String.t()]
  defp split_sentence(sentence) do
    Regex.scan ~r/(*UTF)[\p{L}0-9-]+/i, sentence
  end

end
