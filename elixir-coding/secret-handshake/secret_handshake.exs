defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @secret ["jump", "close your eyes", "double blink", "wink"]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when is_integer(code)do
    <<rev::size(1), jump::size(1), close_your_eyes::size(1), double_blink::size(1),
      wink::size(1)>> = <<code::size(5)>>

    sec_code =
      [jump, close_your_eyes, double_blink, wink]
      |> Enum.zip(@secret)
      |> Enum.reduce([], fn
        {0, _}, acc -> acc
        {1, cmd}, acc -> [cmd | acc]
      end)

    (rev == 1 && Enum.reverse(sec_code)) || sec_code
  end
end