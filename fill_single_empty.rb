class FillSingleEmpty

	def initialize(size = 9)
		@size = size
	end

	def fillup(set)
		
		values = set.collect {|x| x.value}
		count_zeroes = values.count {|x| x == 0}		

		return nil if count_zeroes != 1
		
		missing_number = ((1..@size).to_a - values)[0]

		set.each do |cell|
			if(cell.value == 0)
				cell.value = missing_number				
				return cell
			end
		end
		
	end

end