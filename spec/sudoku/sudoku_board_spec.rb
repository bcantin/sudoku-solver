require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_board" do

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
      cell = @board.get_cell_value(1,2)
      cell.value.should == 5
    end
    
    it "should not be able to set a cell value if the value is not nil" do
      lambda { @board.set_cell_value(1,2,6) }.should raise_error
    end
  end

end

describe "cells" do
  
  before(:each) do
    @cell = Cell.new(1,2)
  end
  it "should have a row and a column" do
    @cell.row.should == 1
    @cell.column.should == 2
  end
  
  it "the value should default to nil" do
    @cell.value.should == nil
  end

end