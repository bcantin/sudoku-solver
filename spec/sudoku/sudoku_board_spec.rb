require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_board" do

  it "a board should have 81 cells" do
    board = SudokuBoard.new
    # board.rows.size.should == 9
  end
end