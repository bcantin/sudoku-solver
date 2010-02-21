class SudokuSolver
  
  ARRY = [1,2,3,4,5,6,7,8,9]
  
  def initialize(board)
    @board = board
  end
  
  def solve!(verbose = nil)
    @verbose = true if verbose
    puts 'i am trying to solve the board' if @verbose
    @guess_found = true
    solve_board
    if @empty_cells.empty?
      return solved_board
    end
    puts 'i am done!' if @verbose
    'not solved'
  end
  
  def solve_board
    until @guess_found == false
      @guess_found = false
      @single_guess_found = true
      @unique_guess       = true

      find_single_guessed_cells_in_a_row
      return if @empty_cells.empty?
      find_unique_guesses
      return if @empty_cells.empty?
    end
  end
  
  def find_single_guessed_cells_in_a_row
    puts 'i am looking for a cell with a single value' if @verbose
    until @single_guess_found == false
      setup_for_searching
      if @single_guess_found
        puts 'i found a cell with a single value!' if @verbose
        @guess_found = true
        collect_and_set_single_guesses
      end
    end
    
    @single_guess_found = false
  end
  
  def collect_and_set_single_guesses
    singles = @empty_cells.select {|c| c.guesses.size == 1}
    singles.each do |c|
      c.value = c.guesses.first
    end
  end
  
  def populate_guesses_for_cells
    @single_guess_found = false
    @empty_cells.each do |empty_cell|
      empty_cell.guesses  = populate_guesses_for_cell(empty_cell)
      @single_guess_found = true if empty_cell.guesses.size == 1
    end
  end
  
  def get_all_empty_cells
    @empty_cells = []
    ARRY.each do |row|
      @empty_cells += get_empty_cells_from_row(row)
    end
    @empty_cells
  end
  
  def get_empty_cells_from_row(row)
    get_empty_cells(@board.get_cells_in_row(row))
  end
  
  def get_empty_cells_from_column(column)
    get_empty_cells(@board.get_cells_in_column(column))
  end
  
  def get_empty_cells_from_box(box)
    get_empty_cells(@board.get_cells_in_box(box))
  end
  
  def populate_guesses_for_cell(cell)
    guesses_from_row = get_missing_values_from_row(cell.row)
    guesses_from_col = get_missing_values_from_column(cell.column)
    guesses_from_box = get_missing_values_from_box(@board.get_box_number_from_cell(cell))
    guesses_from_row & guesses_from_col & guesses_from_box
  end
  
  def find_unique_guesses
    until @unique_guess == false
      break if @empty_cells.empty?
      puts 'i am looking for a unique guess' if @verbose
      @unique_guess = false
      @guess_found  = false
      find_unique_guesses_in_rows
      break if @empty_cells.empty?
      find_unique_guesses_in_columns
      break if @empty_cells.empty?
      find_unique_guesses_in_boxes
    end
  end
  
  private
    
    def setup_for_searching
      get_all_empty_cells
      populate_guesses_for_cells
    end
    
    def find_unique_guesses_in_rows
      puts 'i am looking for a unique guess amoung the rows' if @verbose
      setup_for_searching
      ARRY.each do |row|
        find_unique_guess(get_empty_cells_from_row(row))
      end
    end
    
    def find_unique_guesses_in_columns
      puts 'i am looking for a unique guess amoung the columns' if @verbose
      setup_for_searching
      ARRY.each do |col|
        find_unique_guess(get_empty_cells_from_column(col))
      end
    end
    
    def find_unique_guesses_in_boxes
      puts 'i am looking for a unique guess in the boxes' if @verbose
      setup_for_searching
      ARRY.each do |box|
        find_unique_guess(get_empty_cells_from_box(box))
      end
    end
    
    def find_unique_guess(empty_cells)
      guessed_values = []
      empty_cells.each {|c| guessed_values += c.guesses}

      cells = {}
      ARRY.each do |num|
        cells[num] = 0
        guessed_values.each {|val| cells[num] += 1 if val == num }
      end
 
      cells.each_pair do |number, count|
        if count == 1
          @unique_guess = true
          @guess_found  = true
          cell = empty_cells.select {|c| c.guesses.include?(number)}.first
          puts "i found a unique guess of #{number} in cell #{cell.row}, #{cell.column}" if @verbose
          cell.value = number
        end
      end
    end
    
    
    def solved_board
      @board.show_board
    end
    
    def get_empty_cells(cells)
      empty_cells = cells.select {|c| c if c.empty?}
    end
    
    def get_missing_values(cells)
      populated_values = cells.select {|c| c.value if c.present?}
      ARRY - populated_values.collect(&:value)
    end
    
    def get_missing_values_from_row(row)
      cells = @board.get_cells_in_row(row)
      get_missing_values(cells)
    end
    
    def get_missing_values_from_column(column)
      cells = @board.get_cells_in_column(column)
      get_missing_values(cells)
    end
    
    def get_missing_values_from_box(box)
      cells = @board.get_cells_in_box(box)
      get_missing_values(cells)
    end
    
end