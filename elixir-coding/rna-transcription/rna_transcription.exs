defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
  # dna
  #  |> to_string 
  #  |> String.split("", trim: :true)
  #  |> convert("") 
  #  |> String.to_charlist  
    dna |> Enum.map(&match_dna/1)
  end

  # defp convert([h|t], acc) do 
  #   convert(t, acc<>match_dna(h))
  # end

  # defp convert([], acc), do:  acc
  
  # @spec match_dna(String.t()) :: String.t()
  # defp match_dna(c) do
  #   case c do
  #     "G" -> "C"
  #     "C" -> "G"
  #     "T" -> "A"
  #     "A" -> "U"
  #     _ -> ""
  #   end 
  # end

  @spec match_dna(Integer) :: Integer
  defp match_dna(c) do
    case c do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
    end 
  end
end
