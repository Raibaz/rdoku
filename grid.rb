require 'cell'

class Grid
	attr_reader :size, :rows, :columns, :quadrants, :possible_values

	def initialize(size = 9) 				
		@size = size
		@rows = size
		@columns = size
		@quadrants = size
		@grid = prepare_grid				
		initialize_cells
		@expected_sum = 1.upto(size).inject(0, :+)			
	end

	def initialize_cells
		each_cell do |cell|
			cell.peers = (row(cell.row) + column(cell.column) + quadrant(cell.row, cell.column) - [cell]).uniq
			cell.possible_values = 1.upto(size).to_a
			cell
		end
	end	

	def prepare_grid
		Array.new(rows) do | row |
			Array.new(columns) do | column | 
				Cell.new(row, column)
			end
		end
	end

	def [](row, column)
		return nil unless row.between?(0, @rows-1)
		return nil unless column.between?(0, self.row(column).count - 1)

		@grid[row][column]
	end

	def each_row
		@grid.each do | row |
			yield row
		end
	end

	def each_column
		0.upto(@columns-1) do |col|
			yield column(col)
		end
	end

	def each_quadrant
		(0..@rows-1).step(Math.sqrt(@rows)) do |row|
			(0..@columns-1).step(Math.sqrt(@columns)) do |column|
				yield quadrant(row, column)
			end
		end
	end

	def each_cell
		each_row do | row | 
			row.each do | cell |
				yield cell if cell
			end
		end
	end

	def empty_cells
		ret = []
		each_cell do | cell |
			ret << cell if cell.value == 0
		end
		ret
	end

	def row(index)
		return nil unless index.between?(0, @rows-1)
		@grid[index]
	end

	def column(index)
		return nil unless index.between?(0, @columns-1)
		ret = []
		each_row do | row |
			ret << row[index]
		end
		ret 
	end

	def quadrant(row, column)
		return nil unless row.between?(0, @rows-1)
		return nil unless column.between?(0, self.row(column).count - 1)

		quadrant_size = Math.sqrt(@quadrants)

		quadrant_row = (row / quadrant_size).floor
		quadrant_col = (column / quadrant_size).floor
		
		ret = []

		0.upto(quadrant_size - 1) do | row |
			0.upto(quadrant_size - 1) do | col |
				ret << @grid[row + (quadrant_row * quadrant_size)][col + (quadrant_col * quadrant_size)]
			end
		end

		ret
	end

	def row_values(index)
		return nil unless index.between?(0, @rows-1)
		row(index).collect {|x| x.value}
	end

	def column_values(index)
		return nil unless index.between?(0, @columns-1)
		column(index).collect {|x| x.value}
	end

	def quadrant_values(row, column)
		return nil unless row.between?(0, @rows-1)
		return nil unless column.between?(0, self.row(column).count - 1)
		quadrant(row, column).collect {|x| x.value}
	end

	def row_complete?(index)		
		return false unless index.between?(0, @rows - 1)

		row_sum = row(index).inject(0) { |s, a| s + a.value }	

		row_sum == @expected_sum		
	end

	def column_complete?(index)
		return false unless index.between?(0, @columns - 1)

		column_sum = column(index).inject(0) { |s, a| s + a.value }	

		column_sum == @expected_sum		
	end

	def quadrant_complete?(row, column)
		quadrant = self.quadrant(row, column)

		return false if quadrant == nil

		quadrant_sum = quadrant.inject(0) { |s, a| s + a.value }	

		quadrant_sum == @expected_sum
	end
	
	def self.from_file(file)
		lines = File.readlines(file).map { |line| line.strip }

		lines.pop while lines.last.length < 1

		rows = lines.length		
		grid = Grid.new(rows)

		grid.rows.times do |row|
			grid.columns.times do |col|
				grid[row, col].value = lines[row][col].to_i unless lines[row][col] == 'X'
			end
		end
		grid
	end

	def to_s
		out = ""
		out << "----" * @columns
		out << "\n"
		each_row do | row |
			out << "|"
			row.each do | cell |		
				if(cell.value > 0)
					out << " #{cell.value} |" 
				else
					out << "   |"
				end
			end
			out << "\n"
			out << "----" * @columns
			out << "\n"
		end		
		out
	end

end