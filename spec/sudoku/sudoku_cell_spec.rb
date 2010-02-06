require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_cell" do
  
  before(:each) do
    @cell = SudokuCell.new(1,2)
  end
  it "should have a row and a column" do
    @cell.row.should == 1
    @cell.column.should == 2
  end
  
  it "the value should default to nil" do
    @cell.value.should == nil
  end

end