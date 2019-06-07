defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: get_count(l, 0)
  defp get_count([], acc), do: acc
  defp get_count([_head | tail], acc), do: get_count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l, [])
  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f, [])
  defp do_map([h | t], f, acc), do: do_map(t, f, [f.(h) | acc])
  defp do_map([], _f, acc), do: acc |> reverse

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f, [])
  # defp odd?(value), do: (rem(value, 1) == 1 && true) || false

  defp do_filter([h | t], f, acc),
    do:
      do_filter(
        t,
        f,
        if(f.(h) == true) do
          [h | acc]
        else
          acc
        end
      )

  defp do_filter([], _f, acc), do: acc |> reverse

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f), do: do_reduce(l, acc, f)
  defp do_reduce([h | t], acc, f), do: do_reduce(t, f.(h, acc), f)
  defp do_reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append([], list), do: list
  def append(list, []), do: list

  def append(a, b) do
    a
    |> reverse
    |> do_append(b)
  end

  defp do_append([h | t], b), do: do_append(t, [h | b])
  defp do_append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(ll) do
    ll
    |> reverse
    |> do_concat([])
  end

  defp do_concat([h | t], acc), do: do_concat(t, append(h, acc))
  defp do_concat([], acc), do: acc
end