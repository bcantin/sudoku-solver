require File.dirname(__FILE__) + '/../spec_helper'

describe "sudoku_solver" do
  
  before(:each) do
    @board = SudokuBoard.new
  end
  
  def create_row_with_missing_numbers(row)
    (1..7).each do |num|
      @board.set_cell_value(row,num,num)
    end
    @cell8 = @board.get_cell(1,8)
    @cell9 = @board.get_cell(1,9)
  end
  
  it "should list the missing cells in a row" do
    create_row_with_missing_numbers(1)
    solver = SudokuSolver.new(@board)
    solver.get_empty_cells_from_row(1).should =~ [@cell8,@cell9]
  end
  
end
