class SudokuBoard
  CellNotEmptyError = Class.new(RuntimeError)
  
  attr_accessor :cells
  
  Arry = [1,2,3,4,5,6,7,8,9]
  
  def initialize
    @cells = []
    generate_board_cells
  end
  
  def generate_board_cells
    Arry.each do |row|
      Arry.each do |col|
        @cells << SudokuCell.new(row, col)
      end
    end
  end
    
  def set_cell_value(row,column,value)
    cell = get_cell(row,column)
    raise CellNotEmptyError if cell.value != nil
    cell.value = value
    cell
  end
  
  def set_cell(cell,value)
    set_cell_value(cell.row, cell.column, value)
  end
  
  def get_cell(row,column)
    @cells.each do |c|
    if c.row == row && c.column == column
       return c
     end
    end
  end
  
  def get_cells_in_row(row)
    row_cells=[]
    @cells.each do |c|
      row_cells << c if c.row == row
    end
    row_cells
  end
  
  def get_cells_in_column(col)
    column_cells=[]
    @cells.each do |c|
      column_cells << c if c.column == col
    end
    column_cells
  end
  
  # for a box, we want the ninecells that match
  # that area.
  # 
  # example: box two would be the middle left
  # 
  # 1,1 1,2 1,3
  # 2,1 2,2 1,3
  # 3,1 3,2 3,3
  # -----------
  # 4,1 4,2 4,3
  # 5,1 5,2 5,3
  # 6,1 6,2 6,3
  # -----------
  def get_cells_in_box(box)
    box_cells = []
    center_row, center_column = get_center_of_box(box)
    ((center_row-1)..(center_row+1)).each do |row|
      ((center_column-1)..(center_column+1)).each do |col|
        box_cells << get_cell(row,col)
      end
    end
    box_cells
    # get_center_of_box(box)
  end
  
  def row_complete?(row)
    nine_valid_cells?(get_cells_in_row(row))
  end
  
  def column_complete?(col)
    nine_valid_cells?(get_cells_in_column(col))
  end
  
  def box_complete?(box)
    nine_valid_cells?(get_cells_in_box(box))
  end
  
  private
     def nine_valid_cells?(cells)
       arry = []
       cells.each {|c| arry << c.value if c.present?}
       return true if arry.size == 9 && !arry.uniq!
     end
    
     def get_center_of_box(box_number)
       case box_number
       when 1; return [2,2]
       when 2; return [5,2]
       when 3; return [8,2]
       when 4; return [2,5]
       when 5; return [5,5]
       when 6; return [8,5]
       when 7; return [2,8]
       when 8; return [5,8]
       when 9; return [8,8]
       end
     end
  
end
