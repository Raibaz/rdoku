require_relative '../fill_from_exclusions'
require 'test/unit'


class TestFillFromExclusions < Test::Unit::TestCase

	def test_fill
		grid = Grid.new(4)
		grid[0, 0].value = 1
		grid[0, 1].value = 2
		grid[3, 3].value = 3

		filler = FillFromExclusions.new(grid)

		filler.fill_grid

		assert_equal(4, grid[0, 3].value)
	end

end