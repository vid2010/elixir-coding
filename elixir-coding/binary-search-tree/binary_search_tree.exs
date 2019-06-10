defmodule BinarySearchTree do
  @moduledoc """
  An implementation for the BST operations.
  """
  defstruct [:data, left: nil, right: nil]

  @type t() :: %__MODULE__{
          data: term(),
          left: t() | nil,
          right: t() | nil
        }
  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(term()) :: t()
  def new(data), do: %BinarySearchTree{data: data}

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(t() | nil , term()) :: t()
  def insert(nil, data), do: new(data)

  def insert(tree, data) do
    (tree.data >= data && %{tree | left: insert(tree.left, data)}) ||
      %{tree | right: insert(tree.right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(t() | nil) :: [term()]

  def in_order(tree) do
    case {tree.left, tree.right} do
      {nil, nil} -> [tree.data]
      {left, nil} -> subtree(left, []) ++ [tree.data]
      {nil, right} -> [tree.data] ++ subtree(right, [])
      {left, right} -> subtree(left, []) ++ [tree.data] ++ subtree(right, [])
    end
  end

  defp subtree(tree, acc) do
    case {tree.left, tree.right} do
      {nil, nil} -> [tree.data] ++ acc
      {left, nil} -> subtree(left, [tree.data] ++ acc)
      {nil, right} -> subtree(right, [tree.data] ++ acc)
      {left, right} -> subtree(left, acc) ++ [tree.data] ++ subtree(right, acc)
    end
  end
end