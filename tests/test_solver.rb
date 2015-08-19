require_relative '../solver'
require 'test/unit'


class TestSolver < Test::Unit::TestCase

	def test_most_present_value
		grid = Grid.new(4)
		solver = Solver.new(grid)
		assert_equal(1, solver.most_present_value)

		grid[0, 0].value = 1
		assert_equal(1, solver.most_present_value)

		grid[0, 1].value = 1
		assert_equal(1, solver.most_present_value)

		grid[0, 2].value = 2
		assert_equal(1, solver.most_present_value)

		grid[0, 3].value = 2
		grid[1, 0].value = 2
		assert_equal(2, solver.most_present_value)
	end

	def test_cells_by_val
		grid = Grid.new(2)
		solver = Solver.new(grid)
		grid[0, 0].value = 1
		grid[1, 1].value = 1
		grid[0, 1].value = 2
		grid[1, 0].value = 2

		cells_by_val = solver.cells_by_val		
		assert_equal(2, cells_by_val.count)
		ones = cells_by_val[1]
		twos = cells_by_val[2]

		assert_equal(2, ones.count)
		assert_equal(0, ones[0].row)
		assert_equal(0, ones[0].column)
		assert_equal(1, ones[1].row)
		assert_equal(1, ones[1].column)
		assert_equal(2, twos.count)

	end
	
	def test_can_hold		
		grid = Grid.new(4)
		solver = Solver.new(grid)
		grid[0, 0].value = 1
		grid[0, 1].value = 2
		grid[0, 2].value = 3
		grid[0, 3].value = 4

		grid[1, 0].value = 3
		grid[1, 1].value = 4
		grid[1, 2].value = 2
		grid[1, 3].value = 1

		grid[2, 0].value = 2
		grid[2, 1].value = 1
		grid[2, 2].value = 4
		grid[2, 3].value = 3

		assert_equal(true, solver.can_hold(3, 0, 4))
		assert_equal(false, solver.can_hold(3, 1, 4))
		assert_equal(false, solver.can_hold(3, 2, 4))
		assert_equal(false, solver.can_hold(3, 3, 4))

		assert_equal(false, solver.can_hold(3, 0, 3))
		assert_equal(true, solver.can_hold(3, 1, 3))
		assert_equal(false, solver.can_hold(3, 2, 3))
		assert_equal(false, solver.can_hold(3, 3, 3))

		assert_equal(false, solver.can_hold(3, 0, 1))
		assert_equal(false, solver.can_hold(3, 1, 1))
		assert_equal(true, solver.can_hold(3, 2, 1))
		assert_equal(false, solver.can_hold(3, 3, 1))

		assert_equal(false, solver.can_hold(3, 0, 2))
		assert_equal(false, solver.can_hold(3, 1, 2))
		assert_equal(false, solver.can_hold(3, 2, 2))
		assert_equal(true, solver.can_hold(3, 3, 2))

		assert_equal(true, solver.can_hold(0, 0, 1))
		assert_equal(false, solver.can_hold(0, 0, 2))
		assert_equal(false, solver.can_hold(0, 0, 3))
		
	end
	
end