require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_board" do
  
  def fill_in_entire_row(row)
    (1..9).each do |num|
      @board.set_cell_value(row,num,num)
    end
  end
  
  def fill_in_only_8_columns_in_a_row(row)
    (1..8).each do |num|
      @board.set_cell_value(row,num,num)
    end
  end
  
  def fill_in_entire_column(col)
    (1..9).each do |num|
      @board.set_cell_value(num,col,num)
    end
  end
  
  def fill_in_entire_box(box)
    i=0
    @board.get_cells_in_box(box).each do |cell|
      i+=1
      @board.set_cell(cell, i)
    end
  end
  
  before(:each) do
    @board = SudokuBoard.new
  end

  it "a board should have 81 cells" do
    @board.cells.size.should == 81
  end
  
  it "should be able to set a cell value" do
    @board.set_cell_value(1,2,5).value.should == 5
  end
  
  describe "indivudual cell interaction" do
    before(:each) do
      @board.set_cell_value(1,2,5)
    end
    it "should be able to get the value of a cell" do
      cell = @board.get_cell(1,2)
      cell.value.should == 5
    end
    
    it "should not be able to set a cell value if the value is not nil" do
      lambda { @board.set_cell_value(1,2,6) }.should raise_error
    end
  end
  
  describe "row interaction" do
    it "should contain nine cells" do
      cells = @board.get_cells_in_row(1)
      cells.size.should == 9
    end
    
    it "should return true if all 9 cells in the row have a value" do
      fill_in_entire_row(2)
      @board.row_complete?(2).should == true
    end
    
    it "should return false if all 9 cells in the row do not have a value" do
      fill_in_only_8_columns_in_a_row(8)
      @board.row_complete?(8).should == false
    end
  end
  
  describe "column interaction" do
    it "should contain nine cells" do
      cells = @board.get_cells_in_column(1)
      cells.size.should == 9
    end
    
    it "should return true if all 9 cells in the column have a value" do
      fill_in_entire_column(4)
      @board.column_complete?(4).should == true
    end
  end
  
  describe "box interaction" do
    it "should contain nine cells" do
      cells = @board.get_cells_in_box(5)
      cells.size.should == 9
    end
    
    it "should return true if all 9 cells have a value" do
      fill_in_entire_box(9)
      @board.box_complete?(9).should == true
    end
    
    it "should be able to find the box number given a cell" do
      cell = @board.get_cell(1,1)
      @board.get_box_number_from_cell(cell).should == 1
      cell = @board.get_cell(4,2)
      @board.get_box_number_from_cell(cell).should == 2
      cell = @board.get_cell(9,3)
      @board.get_box_number_from_cell(cell).should == 3
      cell = @board.get_cell(1,6)
      @board.get_box_number_from_cell(cell).should == 4
      cell = @board.get_cell(5,4)
      @board.get_box_number_from_cell(cell).should == 5
      cell = @board.get_cell(7,5)
      @board.get_box_number_from_cell(cell).should == 6
      cell = @board.get_cell(3,9)
      @board.get_box_number_from_cell(cell).should == 7
      cell = @board.get_cell(5,8)
      @board.get_box_number_from_cell(cell).should == 8
      cell = @board.get_cell(9,9)
      @board.get_box_number_from_cell(cell).should == 9
    end
  end
  
end
