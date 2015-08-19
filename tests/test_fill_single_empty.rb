require_relative '../fill_single_empty'
require 'test/unit'

class TestFillSingleEmpty < Test::Unit::TestCase

	def test_fillup
		filler = FillSingleEmpty.new(2)
		grid = Grid.new(2)

		assert_nil(filler.fillup(grid.row(0)))

		grid[0, 0].value = 1
		grid[0, 1].value = 2
		assert_nil(filler.fillup(grid.row(0)))

		grid[0, 0].value = 0
		filled_cell = filler.fillup(grid.row(0))
		assert_equal(1, filled_cell.value)		
		assert_equal(0, filled_cell.row)
		assert_equal(0, filled_cell.column)
	end

end