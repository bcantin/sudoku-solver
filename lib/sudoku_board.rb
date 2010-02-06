class SudokuBoard
  
  attr_accessor :cells
  
  Arry = [1,2,3,4,5,6,7,8,9]
  
  def initialize
    @cells = []
    generate_board_cells
  end
  
  def generate_board_cells
    Arry.each do |row|
      Arry.each do |col|
        @cells << Cell.new(row, col)
      end
    end
  end
  
  ValueAlreadyExistsError = Class.new(RuntimeError)
  
  def set_cell_value(row,column,value)
    cell = get_cell_value(row,column)
    raise ValueAlreadyExistsError if cell.value != nil
    cell.value = value
    cell
  end
  
  def get_cell_value(row,column)
    @cells.each do |c|
    if c.row == row && c.column == column
       return c
     end
    end
  end
end
