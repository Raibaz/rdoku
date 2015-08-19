require 'grid'
require 'fill_single_empty'
require 'fill_from_exclusions'

class Solver

	def initialize(grid)
		@grid = grid
		@single_empties = FillSingleEmpty.new(@grid.size)
		@from_exclusions = FillFromExclusions.new(@grid)
	end

	def solve		
		loop do
			empty_count = @grid.empty_cells.count	
			@grid.each_row do |row|
				@single_empties.fillup(row)
			end

			@grid.each_column do |col|
				@single_empties.fillup(col)
			end

			@grid.each_quadrant do |quad|
				@single_empties.fillup(quad)
			end

			@from_exclusions.fill_grid

			new_count = @grid.empty_cells.count
			break if new_count >= empty_count
		end
		@grid		
	end
	
	def most_present_value
		cells_by_val.max_by{|k,v| v.count}[0]
	end

	def cells_by_val
		ret = {}

		1.upto(@grid.size) do | val |
			ret[val] = []
		end
		
		@grid.each_cell do | cell |			
			ret[cell.value] << cell if cell.value != 0			
		end

		ret
	end

	def can_hold(row, column, value)

		row_count = @grid.row(row).count {|x| x.value == value}
		col_count = @grid.column(column).count {|x| x.value == value}
		quad_count = @grid.quadrant(row, column).count {|x| x.value == value}

		@grid[row, column].value == value || (row_count == 0 && col_count == 0 && quad_count == 0)
	end	

end