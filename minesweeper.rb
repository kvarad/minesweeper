class Board
  attr_reader :board, :bomb_coord_arr
  BOMB_COUNT = 10

  def initialize
    @bomb_coord_arr = []
    @board = Array.new(9) {Array.new(9) {[nil]}}
    @board.each_with_index do |el, x|
      el.each_index do |y|
        @board[x][y] = Tile.new(@board, x, y)
      end
    end
    bomb_shuffler
  end

  def play
    until won?
      display
      puts "Would you like to reveal (R) or flag (F): "
      choice = gets.chomp[0].upcase
      case choice
      when "R"
        puts "Please enter a coordinate (format: x,y ): "
        pos = gets.chomp.split(",")
        @board[pos.first.to_i][pos.last.to_i].reveal(@board)
      when "F"
        puts "Please enter a coordinate (format: x,y ): "
        pos = gets.chomp.split(",")
        @board[pos.first.to_i][pos.last.to_i].flag
      end
    end
  end

  def won?
    won = true
    @board.each do |row|
      row.each do |el|
        won = false if !(el.revealed == true || el.bombed == true)
      end
    end
    won
  end

  def bomb_shuffler
    until @bomb_coord_arr.length == BOMB_COUNT
      x = (0..8).to_a.sample
      y = (0..8).to_a.sample

      @bomb_coord_arr << [x,y] unless @bomb_coord_arr.include?([x,y])
    end

    @bomb_coord_arr.each do |coord|
      @board[coord.first][coord.last].bombed = true
    end
  end

  def display
    print "  012345678\n"
    print "-----------\n"
    @board.each_with_index do |el, x|
      print "#{x}|"
      el.each_index do |y|
        print @board[x][y].display
      end
      print "\n"
    end
    print "\n"
    nil
  end

end

class Tile
  attr_accessor :position, :bombed, :flagged, :revealed, :display

  MOVES = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
  ]

  def initialize(board, x, y)
    @board = board
    @position = [x, y]
    @bombed = false
    @flagged = false
    @revealed = false
    @display = "*"
  end

  def reveal(board)
    bomb_counter = 0
    if self.bombed
      puts "Game Over"
    else
      next_moves = neighbors(@position.first, @position.last)
      next_moves.each do |position|
        current_pos = board[position.first][position.last]
        bomb_counter += 1 if current_pos.bombed
      end
      if bomb_counter == 0
        @revealed = true
        @display = "_"
        next_moves.each do |position|
          current_pos = board[position.first][position.last]
          current_pos.reveal(board) unless current_pos.revealed
        end
      else
        @revealed = true
        @display = bomb_counter
      end
    end
  end

  # def inspect
  #
  # end

  def neighbors(x, y)
    new_coord_arr = []
    MOVES.each do |move|
      new_x = move.first + x
      new_y = move.last + y
      if (0..8).include?(new_x) && (0..8).include?(new_y)
        new_coord_arr << [new_x, new_y]
      end
    end
    new_coord_arr
  end

  def flag
    unless @revealed
      if @flagged == false
        @flagged = true
        @display = "F"
      else
        @flagged = false
        @display = "*"
      end
    else
      puts "You cannot flag a revealed tile."
    end
  end

  def neighbor_bomb_count

  end
end
