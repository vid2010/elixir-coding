defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown_string) do
    markdown_string
    |> String.split("\n")
    |> Enum.map(&process_md/1)
    |> Enum.join()
    |> to_html
  end

  defp process_md(line = "#" <> _), do: enclose_with_header_tag(parse_header_md_level(line))
  defp process_md(line = "*" <> _), do: parse_list_md_level(line)
  defp process_md(line), do: enclose_with_paragraph_tag(String.split(line))

  defp parse_header_md_level(line) do
    [h | t] = String.split(line)

    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(line) do
    bullet_point =
      line
      |> String.trim_leading("* ")
      |> String.split()
      |> join_words_with_tags

    "<li>" <> bullet_point <> "</li>"
  end

  defp enclose_with_header_tag({header_length, header_tail}) do
    "<h" <> header_length <> ">" <> header_tail <> "</h" <> header_length <> ">"
  end

  defp enclose_with_paragraph_tag(word_list) do
    "<p>#{join_words_with_tags(word_list)}</p>"
  end

  defp join_words_with_tags(words) do
    words
    |> Enum.map_join(" ", &replace_md_with_tag/1)
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp to_html(line) do
    line
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end