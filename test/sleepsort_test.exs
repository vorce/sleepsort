defmodule SleepsortTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest Sleepsort

  describe "sort/1" do
    test "sorts a small list" do
      items = [2, 3, 1]
      assert Sleepsort.sort(items) == [1, 2, 3]
    end

    property "returns the same as Enum.sort" do
      check all numbers <- StreamData.list_of(StreamData.integer(0..100), max_length: 100),
                max_runs: 100 do
        assert Sleepsort.sort(numbers) == Enum.sort(numbers)
      end
    end
  end
end
