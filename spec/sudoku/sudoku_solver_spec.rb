require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_solver" do
  
  before(:each) do
    @board  = SudokuBoard.new
    @solver = SudokuSolver.new(@board)
  end
  
  def create_row_with_missing_numbers(row)
    (1..7).each do |num|
      @board.set_cell_value(row,num,num)
    end
    @cell8 = @board.get_cell(row,8)
    @cell9 = @board.get_cell(row,9)
  end
  
  def create_column_with_missing_numbers(col)
    (1..7).each do |num|
      @board.set_cell_value(num,col,num)
    end
    @cell8 = @board.get_cell(8,col)
    @cell9 = @board.get_cell(9,col)
  end
  
  def create_box_9_with_missing_numbers
    cells = @board.get_cells_in_box(9)
    (1..7).each do |num|
      @board.set_cell(cells[num-1],num)
    end
    @cell8 = @board.get_cell(9,8)
    @cell9 = @board.get_cell(9,9)
  end
  # _ 6 _  1 _ 4  _ 5 _ 
  # _ _ 8  3 _ 5  6 _ _ 
  # 2 _ _  _ _ _  _ _ 1 
  # 8 _ _  4 _ 7  _ _ 6 
  # _ _ 6  _ _ _  3 _ _ 
  # 7 _ _  9 _ 1  _ _ 4 
  # 5 _ _  _ _ _  _ _ 2 
  # _ _ 7  2 _ 6  9 _ _ 
  # _ 4 _  5 _ 8  _ 7 _
  def create_partially_full_board
    @board.import_from_array([
      nil,  6,nil,  1,nil,  4,nil,  5,nil,
      nil,nil,  8,  3,nil,  5,  6,nil,nil,
        2,nil,nil,nil,nil,nil,nil,nil,  1,
        8,nil,nil,  4,nil,  7,nil,nil,  6,
      nil,nil,  6,nil,nil,nil,  3,nil,nil,
        7,nil,nil,  9,nil,  1,nil,nil,  4,
        5,nil,nil,nil,nil,nil,nil,nil,  2,
      nil,nil,  7,  2,nil,  6,  9,nil,nil,
      nil,  4,nil,  5,nil,  8,nil,  7,nil
    ])
  end
  
  it "list the missing cells in a row" do
    create_row_with_missing_numbers(1)
    @solver.get_empty_cells_from_row(1).should =~ [@cell8,@cell9]
  end
  
  it "list the missing cells in a column" do
    create_column_with_missing_numbers(7)
    @solver.get_empty_cells_from_column(7).should =~ [@cell8,@cell9]
  end
  
  it "list the missing cells in a box" do
    create_box_9_with_missing_numbers
    @solver.get_empty_cells_from_box(9).should =~ [@cell8,@cell9]
  end
  
  it "list the possible values for an empty cell" do
    create_partially_full_board
    cell = @board.get_cell(1,1)
    @solver.populate_guesses_for_cell(cell).should =~ [3,9]
  end
  
  it "should get all of the empty cells" do
    create_partially_full_board
    @solver.get_all_empty_cells.count.should == 51
  end
  
  describe "easy board" do
    def create_easy_board
      @board.import_from_array([
        0,2,0,5,9,4,7,3,1,
        1,3,9,7,2,0,4,0,0,
        5,7,4,1,0,8,9,2,6,
        9,1,0,3,0,0,5,4,2,
        7,8,2,0,1,0,6,9,3,
        3,4,5,0,0,9,0,1,7,
        8,5,3,6,0,1,2,7,9,
        0,0,7,0,5,3,1,6,4,
        4,6,1,9,7,2,0,5,0
      ])
    end
    
    before(:each) do
      create_easy_board
    end
    it "should find 20 empty cells" do
      @solver.get_all_empty_cells.count.should == 20
    end
    
    it "should be able to solve the simple board" do
      @solver.solve!.should_not == 'not solved'
    end
    
    it "should solve the board" do
      @solver.solve!
      @board.show_board.should == [
        %w[6 2 8 5 9 4 7 3 1],
        %w[1 3 9 7 2 6 4 8 5],
        %w[5 7 4 1 3 8 9 2 6],
        %w[9 1 6 3 8 7 5 4 2],
        %w[7 8 2 4 1 5 6 9 3],
        %w[3 4 5 2 6 9 8 1 7],
        %w[8 5 3 6 4 1 2 7 9],
        %w[2 9 7 8 5 3 1 6 4],
        %w[4 6 1 9 7 2 3 5 8]]
    end
  end
  
  describe "medium board" do
    def create_medium_board
      @board.import_from_array([
        8, 0, 7, 9, 0, 0, 0, 0, 0,
        6, 0, 0, 0, 0, 0, 0, 0, 0,
        3, 2, 1, 4, 6, 5, 0, 9, 0,
        2, 7, 0, 0, 0, 4, 0, 8, 5,
        5, 1, 0, 2, 0, 6, 0, 4, 0,
        4, 0, 0, 7, 0, 0, 0, 1, 0,
        9, 8, 4, 6, 7, 1, 5, 3, 2,
        1, 0, 0, 0, 0, 0, 0, 7, 0,
        7, 0, 0, 0, 0, 8, 1, 6, 4
      ])
            
    end
    
    before(:each) do
      create_medium_board
    end
    
    it "should not solve the board for now" do
      puts @board.show_board.inspect
      @solver.solve!
      puts @board.show_board.inspect
    end
  end
end
