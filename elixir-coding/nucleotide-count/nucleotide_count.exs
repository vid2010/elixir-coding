defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count_char(strand, nucleotide, 0)
  end

  defp count_char([h | t], nucleotide, count),
    do: count_char(t, nucleotide, (h == nucleotide && count + 1) || count)

  defp count_char([], _nucleotide, count), do: count

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    count_histogram(strand, @nucleotides, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  end

  defp count_histogram(strand, [h | t], acc),
    do: count_histogram(strand, t, Map.merge(acc, %{h => count(strand, h)}))

  defp count_histogram([], _, acc), do: acc
  defp count_histogram(_, [], acc), do: acc
end