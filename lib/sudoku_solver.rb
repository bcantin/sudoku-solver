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
    guesses_from_row = get_missing_values_from_row(cell.row)
    guesses_from_col = get_missing_values_from_column(cell.column)
    guesses_from_box = get_missing_values_from_box(@board.get_box_number_from_cell(cell))
    guesses_from_row & guesses_from_col & guesses_from_box
  end
  
  private
  
    def get_empty_cells(cells)
      empty_cells = cells.select {|c| c if c.empty?}
    end
    
    def get_missing_values(cells)
      populated_values = cells.select {|c| c.value if c.present?}
      Arry - populated_values.collect(&:value)
    end
    
    def get_missing_values_from_row(row)
      cells = @board.get_cells_in_row(row)
      get_missing_values(cells)
    end
    
    def get_missing_values_from_column(column)
      cells = @board.get_cells_in_column(column)
      get_missing_values(cells)
    end
    
    def get_missing_values_from_box(box)
      cells = @board.get_cells_in_box(box)
      get_missing_values(cells)
    end
    
end