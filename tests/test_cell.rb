require_relative '../grid'
require 'test/unit'


class TestCell < Test::Unit::TestCase

	def test_peers
		grid = Grid.new(4)	

		grid.each_cell do | cell |			
			assert_equal(7, cell.peers.count)
		end		
	end	

	def test_exclude
		cell = Cell.new(0, 0)

		assert_equal([], cell.excluded_values)
		cell.exclude(1)
		assert_equal([1], cell.excluded_values)
		cell.exclude(2)
		assert_equal([1,2], cell.excluded_values)
		cell.exclude(1)
		assert_equal([1, 2], cell.excluded_values)
	end

	def test_exclude_from_peers_when_setting
		grid = Grid.new(2)
		grid[0, 0].value = 1
		grid[0, 0].peers.each do |cell|
			assert_equal([1], cell.excluded_values)
		end
	end

end