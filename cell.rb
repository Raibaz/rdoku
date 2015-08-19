class Cell
	attr_reader :row, :column, :excluded_values
	attr_accessor :value, :peers

	def initialize(row, column)
		@row, @column = row, column
		@value = 0		
		@excluded_values = []
	end

	def exclude(value)
		@excluded_values << value unless @excluded_values.include?(value)		
	end

	def value=(value)
		@value = value
		peers.each do | peer |
			peer.exclude(value)
		end
	end

	def ==(other)
		other.class == self.class && @row == other.row && @column == other.column
	end

	def to_s
		return "#{row}, #{column} => #{value}"
	end

end