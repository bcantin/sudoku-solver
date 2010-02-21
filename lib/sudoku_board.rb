class SudokuBoard
  CellNotEmptyError = Class.new(RuntimeError)
  InvaidImportedArrayError = Class.new(RuntimeError)
  
  attr_accessor :cells
  
  ARRY = [1,2,3,4,5,6,7,8,9]
  
  def initialize
    @cells = []
    generate_board_cells
  end
  
  def show_board
    a = []
    ARRY.each do |row|
      r = []
      get_cells_in_row(row).each do |cell|
        val = cell.value ? cell.value : 0
        r << val.to_s
      end
      a << r
    end
    a
  end
  
  def import_from_array(imported_array)
    raise InvaidImportedArrayError unless imported_array.size == 81
    i = 0
    @cells.each do |c|
      set_cell(c, imported_array[i]) if ARRY.include?(imported_array[i])
      i += 1
    end
  end
  
  def generate_board_cells
    ARRY.each do |row|
      ARRY.each do |col|
        @cells << SudokuCell.new(row, col)
      end
    end
  end
    
  def set_cell_value(row,column,value)
    cell = get_cell(row,column)
    raise CellNotEmptyError if cell.present?
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
    row_cells = @cells.select {|c| c.row == row}
  end
  
  def get_cells_in_column(col)
    column_cells = @cells.select {|c| c.column == col}
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
  end
  
  def get_box_number_from_cell(cell)
    a = [1,2,3]
    b = [4,5,6]
    c = [7,8,9]
    case
    when a.include?(cell.row) && a.include?(cell.column)
      1
    when b.include?(cell.row) && a.include?(cell.column)
      2
    when c.include?(cell.row) && a.include?(cell.column)
      3
    when a.include?(cell.row) && b.include?(cell.column)
      4
    when b.include?(cell.row) && b.include?(cell.column)
      5
    when c.include?(cell.row) && b.include?(cell.column)
      6
    when a.include?(cell.row) && c.include?(cell.column)
      7
    when b.include?(cell.row) && c.include?(cell.column)
      8
    when c.include?(cell.row) && c.include?(cell.column)
      9
    end
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
       a = cells.select {|c| c.value if c.present?}
       return true if a.size == 9 && !a.uniq!
       false
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
