class SudokuCell
  
  attr_reader :row, :column
  attr_accessor :value, :guesses
  
  def initialize(row, column, val=nil)
    @value = val if val
    @row, @column = row, column
    @guesses = []
  end
  
  def to_s
    "{:row => #{@row}, :column => #{@column}, :value => #{@value}, :guesses => #{@guesses}}"
  end
  
  # we are checking the value, not the cell
  def present?
    !value.nil?
  end
  
  def empty?
    value.nil?
  end
  
  def value=(val)
    @guesses = []
    @value   = val
  end
  
end