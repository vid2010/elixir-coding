defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      all_letters_uppercase?(input) and String.ends_with?(input, "?") ->
        "Calm down, I know what I'm doing!"

      all_letters_uppercase?(input) ->
        "Whoa, chill out!"

      String.ends_with?(input, "?") ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp all_letters_uppercase?(input) do
    String.upcase(input) == input &&
      String.downcase(input) != input
  end
end