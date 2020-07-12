class Chess

  def initialize()
    @turn="white"
    @game_over=false
  end

end


class Piece
  attr_reader :position, :color
  def initialize(color,position)
    @color=color
    @position=position
  end

  public
  def update_pos(new_pos)
    @position=new_pos
  end
end

class Pawn < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♙" if @color.downcase=="white"
    @symbol="♟︎" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
class Knight < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♘" if @color.downcase=="white"
    @symbol="♞" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
class Bishop < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♗" if @color.downcase=="white"
    @symbol="♝" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
class Rook < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♖" if @color.downcase=="white"
    @symbol="♜" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
class Queen < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♕" if @color.downcase=="white"
    @symbol="♛" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
class King < Piece
  attr_reader :symbol
  def initialize(color, position)
    super(color,position)
    @symbol="♔" if @color.downcase=="white"
    @symbol="♚" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
