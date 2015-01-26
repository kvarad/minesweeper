class Board
  attr_reader :board

  def initialize
    @board = Array.new(9) {Array.new(9) {[nil]}}
    @board.each_with_index do |el, x|
      el.each_index do |y|
        @board[x][y] = Tile.new(@board, x, y)
      end
    end
  end

  # def reveal(x, y)
  #    if @board[x][y] == "B"
  #      puts "Game Over"
  #    elsif @board[x][y].nil?
  #      next_moves = possible_moves(x, y)
  #    end
  # end

  # def possible_moves(x, y)
  #   new_coord_arr = []
  #   MOVES.each do |move|
  #     new_x = move.first + x
  #     new_y = move.last + y
  #     if (0..8).include?(new_x) && (0..8).include?(new_y)
  #       new_coord_arr << [new_x, new_y]
  #     end
  #   end
  #   new_coord_arr
  # end

  # def checker(new_coord_arr)
  #
  # end

end

class Tile
  attr_accessor :position, :bombed, :flagged, :revealed, :display

  MOVES = [[-1, 0],
  [-1, -1],
  [-1, 0],
  [0, -1],
  [0, 1],
  [-1, 1],
  [1, 0],
  [1, 1]]

  def initialize(board, x, y)
    @board = board
    @position = [x, y]
    @bombed = false
    @flagged
    @revealed = false
    @display = "_"
  end

  def reveal(board)
    bomb_counter = 0
    if self.bombed
      puts "Game Over"
    else
      next_moves = neighbors(@position.first, @position.last)
      next_moves.each do |position|
        if board[position.first][position.last].bombed
          bomb_counter += 1
        end
        if bomb_counter == 0
          @revealed = true
          @display = "X"
        else
          @revealed = true
          @display = bomb_counter
        end
      end
    end
  end

  def inspect

  end

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

  def neighbor_bomb_count

  end
end
