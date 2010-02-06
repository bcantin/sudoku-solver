class SudokuBoard
  
  attr_accessor :rows
  attr_accessor :cols
  attr_accessor :board
  
  Arry = [1,2,3,4,5,6,7,8,9]
  
  def initialize
    @board = {}
    generate_board_cells
  end
  
  def generate_board_cells
    Arry.each do |row|
      Arry.each do |col|
        Cell.new(row, col)
      end
    end
  end
  
end

class Cell
  
  def initialize(row, column)
     @row, @column = row, column
  end
end