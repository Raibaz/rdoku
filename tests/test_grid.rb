require_relative '../grid'
require 'test/unit'


class TestGrid < Test::Unit::TestCase
	
	def test_init
		grid = Grid.new(2)
		assert_equal(2, grid.rows)
		assert_equal(2, grid.columns)
		assert_equal(2, grid.quadrants)

		grid = Grid.new
		assert_equal(9, grid.rows)
		assert_equal(9, grid.columns)
		assert_equal(9, grid.quadrants)
	end

	def test_get_cell
		grid = Grid.new(3)
		assert_nil(grid[10, 10])
		assert_nil(grid[-1, -1])
		assert_equal(0, grid[0, 0].value)
		grid[0, 0].value = 1
		assert_equal(1, grid[0, 0].value)
	end

	def test_get_empty_cells
		grid = Grid.new(2)
		assert_equal(4, grid.empty_cells.count)
		grid[0, 0].value = 1
		assert_equal(3, grid.empty_cells.count)
	end

	def test_get_row
		grid = Grid.new(3)
		assert_nil(grid.row(-1))
		assert_nil(grid.row(3))
		row = grid.row(0)
		assert_equal(3, row.count)
		assert_equal(0, row[0].row)
		assert_equal(0, row[0].column)
		assert_equal(0, row[1].row)
		assert_equal(1, row[1].column)
		assert_equal(0, row[2].row)
		assert_equal(2, row[2].column)
	end

	def test_get_column
		grid = Grid.new(3)
		assert_nil(grid.column(-1))
		assert_nil(grid.column(3))
		column = grid.column(0)
		assert_equal(3, column.count)
		assert_equal(0, column[0].row)
		assert_equal(0, column[0].column)
		assert_equal(1, column[1].row)
		assert_equal(0, column[1].column)
		assert_equal(2, column[2].row)
		assert_equal(0, column[2].column)
	end

	def test_get_quadrant
		grid = Grid.new(4)
		assert_nil(grid.quadrant(-1, -1))
		assert_nil(grid.quadrant(4, 4))

		quadrant = grid.quadrant(0, 0)
		assert_equal(4, quadrant.count)
		assert_equal(0, quadrant[0].row)
		assert_equal(0, quadrant[0].column)
		assert_equal(0, quadrant[1].row)
		assert_equal(1, quadrant[1].column)
		assert_equal(1, quadrant[2].row)
		assert_equal(0, quadrant[2].column)
		assert_equal(1, quadrant[3].row)
		assert_equal(1, quadrant[3].column)

		quadrant = grid.quadrant(1, 0)
		assert_equal(4, quadrant.count)
		assert_equal(0, quadrant[0].row)
		assert_equal(0, quadrant[0].column)
		assert_equal(0, quadrant[1].row)
		assert_equal(1, quadrant[1].column)
		assert_equal(1, quadrant[2].row)
		assert_equal(0, quadrant[2].column)
		assert_equal(1, quadrant[3].row)
		assert_equal(1, quadrant[3].column)

		quadrant = grid.quadrant(3, 3)
		assert_equal(4, quadrant.count)
		assert_equal(2, quadrant[0].row)
		assert_equal(2, quadrant[0].column)
		assert_equal(2, quadrant[1].row)
		assert_equal(3, quadrant[1].column)
		assert_equal(3, quadrant[2].row)
		assert_equal(2, quadrant[2].column)
		assert_equal(3, quadrant[3].row)
		assert_equal(3, quadrant[3].column)
	end

	def test_row_values
		grid = Grid.new(2)
		grid[0, 0].value = 1
		grid[0, 1].value = 2

		assert_equal([1, 2], grid.row_values(0))
		assert_equal([0, 0], grid.row_values(1))
		assert_nil(grid.row_values(-1))
		assert_nil(grid.row_values(2))
	end

	def test_column_values
		grid = Grid.new(2)
		grid[0, 0].value = 1
		grid[0, 1].value = 2

		assert_equal([1, 0], grid.column_values(0))
		assert_equal([2, 0], grid.column_values(1))
		assert_nil(grid.row_values(-1))
		assert_nil(grid.row_values(2))
	end

	def test_quadrant_values
		grid = Grid.new(4)
		grid[0, 0].value = 1
		grid[0, 1].value = 2
		grid[1, 0].value = 3
		grid[1, 1].value = 4

		assert_equal([1, 2, 3, 4], grid.quadrant_values(0, 0))
		assert_equal([0, 0, 0, 0], grid.quadrant_values(2, 2))
		assert_nil(grid.quadrant_values(-1, -1))
		assert_nil(grid.quadrant_values(-1, 0))

	end

	def test_row_complete
		grid = Grid.new(2)
		grid[0, 0].value = 1
		grid[0, 1].value = 2
		assert_equal(true, grid.row_complete?(0))
		assert_equal(false, grid.row_complete?(1))
		assert_equal(false, grid.row_complete?(-1))
		assert_equal(false, grid.row_complete?(2))
	end

	def test_column_complete
		grid = Grid.new(2)
		grid[0, 0].value = 1
		grid[1, 0].value = 2
		assert_equal(true, grid.column_complete?(0))
		assert_equal(false, grid.column_complete?(1))
		assert_equal(false, grid.column_complete?(-1))
		assert_equal(false, grid.column_complete?(2))
	end

	def test_quadrant_complete
		grid = Grid.new(4)
		assert_equal(false, grid.quadrant_complete?(-1, -1))
		assert_equal(false, grid.quadrant_complete?(4, 4))

		grid[0, 0].value = 1
		grid[0, 1].value = 2
		grid[1, 1].value = 3
		grid[1, 0].value = 4

		assert_equal(true, grid.quadrant_complete?(0, 0))
		assert_equal(true, grid.quadrant_complete?(0, 1))
		assert_equal(true, grid.quadrant_complete?(1, 1))
		assert_equal(true, grid.quadrant_complete?(1, 0))
	end

	def test_complete_grid
		grid = Grid.new(4)
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

		grid[3, 0].value = 4
		grid[3, 1].value = 3
		grid[3, 2].value = 1
		grid[3, 3].value = 2
				
		0.upto(3) do | index |			
			assert_equal(true, grid.row_complete?(index))
			assert_equal(true, grid.column_complete?(index))

			0.upto(3) do | col |
				assert_equal(true, grid.quadrant_complete?(index, col))
			end
		end
	end

end