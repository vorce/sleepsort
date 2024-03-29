defmodule Sleepsort do
  @moduledoc """
  An implementation of the silly sleep sort algorithm.
  It can sort inputs of numbers that are equal to or greater than 0.
  """

  @doc """
  Sort a list of numbers >= 0
  """
  @spec sort(numbers :: list(number)) :: list(number)
  def sort(numbers) when is_list(numbers) do
    opts = [timeout: :infinity, ordered: false, max_concurrency: max(1, length(numbers))]

    numbers
    |> Task.async_stream(&sleepy/1, opts)
    |> Enum.reduce([], fn {:ok, num}, acc ->
      [num | acc]
    end)
    |> Enum.reverse()
  end

  defp sleepy(input) when is_number(input) and input >= 0 do
    # Use a factor here to avoid issues with really close numbers
    :timer.sleep(input * 2)
    input
  end
end
