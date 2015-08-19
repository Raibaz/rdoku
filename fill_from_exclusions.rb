require 'grid'

class FillFromExclusions

	def initialize(grid)
		@grid = grid
	end

	def fill_grid
		@grid.each_cell do |cell|
			next if cell.excluded_values.count != @grid.size - 1

			missing_excluded = ((1..@grid.size).to_a - cell.excluded_values)[0]

			cell.value = missing_excluded
			
		end
		@grid
	end

end