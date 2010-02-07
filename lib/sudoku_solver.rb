class SudokuSolver
  
  Arry = [1,2,3,4,5,6,7,8,9]
  
  def initialize(board)
    @board = board
  end
  
  def get_empty_cells_from_row(row)
    get_empty_cells(@board.get_cells_in_row(row))
  end
  
  def get_empty_cells_from_column(column)
    get_empty_cells(@board.get_cells_in_column(column))
  end
  
  def get_empty_cells_from_box(box)
    get_empty_cells(@board.get_cells_in_box(box))
  end
  
  def populate_guesses_for_cell(cell)
    
  end
  
  private
  
    def get_empty_cells(cells)
      empty_cells = []
      cells.each {|c| empty_cells << c if c.empty?}
      empty_cells
    end
end