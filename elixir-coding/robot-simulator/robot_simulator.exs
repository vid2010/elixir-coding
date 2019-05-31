defmodule RobotInstruction.Guards do
  defguard is_valid_direction(value) when is_atom(value) and value not in [:invalid]
  defguard is_valid_position(value) when is_tuple(value) and tuple_size(value) == 2 and is_integer(elem(value, 0)) and is_integer(elem(value, 1))
end

defmodule RobotSimulator do
  @moduledoc """
  Provides the set of instructions for the robot movement directions.
  """
  defstruct direction: :north, position: {0, 0}

  @typedoc """
  Defines a basic instruction storage type of type `RobotSimulator.t()`.
  """
  @type t :: %__MODULE__{direction: atom(), position: tuple()}
  import RobotInstruction.Guards
  

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def create(direction \\ :north, position \\ {0, 0})

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, position) when is_valid_direction(direction) and is_valid_position(position) do
    %__MODULE__{direction: direction, position: position}
  end

  def create(_, position) when is_valid_position(position) do
    {:error, "invalid direction"}
  end

  def create(direction, _) when is_valid_direction(direction) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: t(), instructions :: String.t()) :: t() | {:error, String.t()}
  def simulate(robot, instructions) when is_binary(instructions) do
    instructions
    |> String.codepoints()
    |> Enum.reduce(robot, &follow_instruction/2)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(any) :: atom
  def direction(%{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(any) :: {integer, integer}
  def position(%{position: position}), do: position

  @spec follow_instruction(instructions :: binary(), robot :: t()) :: t() | {:error, String.t()}
  def follow_instruction(instruction, %{direction: direction, position: position} = robot) do
    case instruction do
      "L" -> %__MODULE__{robot | direction: turn_left(direction)}
      "R" -> %__MODULE__{robot | direction: turn_right(direction)}
      "A" -> %__MODULE__{robot | position: advance(direction, position)}
      _ -> {:error, "invalid instruction"}
    end
  end

  def follow_instruction(_instruction, {:error, "invalid instruction"}),
    do: {:error, "invalid instruction"}

  defp turn_right(dir) when is_atom(dir) do
    case dir do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  defp turn_left(dir) when is_atom(dir) do
    case dir do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end
  end

  defp advance(direction, {x, y}) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end
end