defmodule AdventOneTest do
  use ExUnit.Case
  alias AdventOne

  @moduletag :advent_one

  describe "solve/1" do
    setup do
      # Create temporary files for testing
      {:ok, tmp_dir} = Briefly.create(directory: true)
      {:ok, tmp_dir: tmp_dir}
    end

    test "returns 0 when no rotation lands on zero", %{tmp_dir: tmp_dir} do
      file = Path.join(tmp_dir, "input.txt")
      File.write!(file, "R1\nL1\nR1\nL1")
      assert AdventOne.solve(file) == 0
    end

    test "returns correct count when some rotations land on zero", %{tmp_dir: tmp_dir} do
      file = Path.join(tmp_dir, "input.txt")
      File.write!(file, "R50\nL50\nR10")
      assert AdventOne.solve(file) == 1
    end

    test "handles mixed directions and distances", %{tmp_dir: tmp_dir} do
      file = Path.join(tmp_dir, "input.txt")
      File.write!(file, "R50\nL25\nR25\nL50")
      assert AdventOne.solve(file) == 2
    end

    test "handles unknown direction gracefully", %{tmp_dir: tmp_dir} do
      file = Path.join(tmp_dir, "input.txt")
      File.write!(file, "X10\nR50\nL50")
      assert AdventOne.solve(file) == 1
    end

    test "works with the provided input.txt file" do
      result = AdventOne.solve("advent_one/input.txt")
      assert is_integer(result)
      assert result >= 0
    end
  end
end
