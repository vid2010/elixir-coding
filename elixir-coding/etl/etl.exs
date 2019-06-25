defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    ## 1st solution
    input
    |> Enum.map(fn {key, val} ->
      Enum.reduce(val, %{}, fn x, acc ->
        Map.put(acc, String.downcase(x), key)
      end)
    end)
    |> Enum.reduce(%{}, &Map.merge/2)
  
  ## Another solution-
  
  # for {key, value} <- input, v <- value, into: %{}, do: {String.downcase(v), key} 
  end
end