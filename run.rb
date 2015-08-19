require 'solver'

abort "Please specify a text file to use as a template" if ARGV.empty?

grid = Grid.from_file(ARGV.first)
solver = Solver.new(grid)

puts grid

solver.solve

puts grid
