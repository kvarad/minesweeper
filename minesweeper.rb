class Board
  MOVES = [[-1, 0],
          [-1, -1],
          [-1, 0],
          [0, -1],
          [0, 1],
          [-1, 1],
          [1, 0],
          [1, 1]]

  def initialize
    @board = Array.new(9) {Array.new(9) {[nil]}}
  end

  def reveal(x, y)
    if @board[x][y] == "B"
      puts "Game Over"
    elsif @board[x][y].nil?
      next_moves = possible_moves(x, y)
      
    end
  end

  def possible_moves(x, y)
    return_array = []
    MOVES.each do |move|
      new_x = move.first + x
      new_y = move.last + y
      if (0..8).include?(new_x) && (0..8).include?(new_y)
        return_array << [new_x, new_y]
      end
    end
    return_array
  end


end
