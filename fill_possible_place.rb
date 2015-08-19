require 'grid'

class FillPossiblePlace

	def initialize(grid)
		@grid = grid
	end

	def fill_grid
		@grid.each_row do |row|
			run_fill(row)
		end

		@grid.each_column do |col|
			run_fill(col)
		end

		@grid.each_quadrant do |quad|
			run_fill(quad)
		end
	end

private

	def run_fill(set)
		empty_cells = set.select {|x| x.value == 0}

		return if empty_cells.count > 3

		empty_cells.each do | cell |
			candidate = cell.possible_values
			(empty_cells - [cell]).each do | other_cell |
				candidate = candidate - other_cell.possible_values
			end

			cell.value = candidate[0] if candidate.count == 1
		end		
	end

end