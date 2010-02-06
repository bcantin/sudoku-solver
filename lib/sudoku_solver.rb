class SudokuSolver
  
  Arry = [1,2,3,4,5,6,7,8,9]
  
  def initialize(board)
    @board = board
  end
  
  def get_empty_cells_from_row(row)
    empty_cells = []
    cells = @board.get_cells_in_row(row)
    cells.each {|c| empty_cells << c if c.empty?}
    empty_cells
  end
end