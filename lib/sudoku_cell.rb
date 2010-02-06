class SudokuCell
  
  attr_reader :row, :column
  attr_accessor :value, :guesses
  
  def initialize(row, column, val=nil)
    @val = val if val
    @row, @column = row, column
    @value = val if val
    @guesses = []
  end
  
  def to_s
    "{:row => #{@row}, :column => #{@column}, :value => #{@value}}"
  end
end