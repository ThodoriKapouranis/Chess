class Chess
  attr_reader :board, :turn, :game_over
  def initialize()
    @turn="white"
    @game_over=false
    @board=[
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
      ["☐","☐","☐","☐","☐","☐","☐","☐"],
    ]
    @parse_hash={
      0 => "a",
      1 => "b",
      2 => "c",
      3 => "d",
      4 => "e",
      5 => "f",
      6 => "g",
      7 => "h",
    }
  end

  public 
  def play()
    default_board_start()
    display()
    make_move("a2","a3")
    p @board[5][0]
    display()
  end

  def display
    @board[0][3]="♛"
    @board.each_with_index {|row,index| print (8-index).to_s+" "+row.join(" ")+"\n"}
    print "0 a b c d e f g h\n\n"
  end

  def make_move(from,to) #Expecting "a4"-like notation
    from_y = parse_tile(from)[0].join.to_i  # [6] -> 6
    from_x = parse_tile(from)[1].join.to_i
    to_y   = parse_tile(to)[0].join.to_i
    to_x   = parse_tile(to)[1].join.to_i

    allowable_moves = @board[from_y][from_x].check_moves
    if true   # allowable_moves.includes?([to_y,to_x])
      @board[to_y][to_x]= @board[from_y][from_x]
      @board[to_y][to_x].update_pos(to)
      @board[from_y][from_x]="☐"
    end
  end
  
  private
  def default_board_start
    @board[0][0]=Rook.new("black","a8")
    @board[0][1]=Knight.new("black","b8")
    @board[0][2]=Bishop.new("black","c8")
    @board[0][3]=Queen.new("black","d8")
    @board[0][4]=King.new("black","e8")
    @board[0][5]=Bishop.new("black","f8")
    @board[0][6]=Knight.new("black","g8")
    @board[0][7]=Rook.new("black","h8")
    8.times {|x| @board[1][x]=Pawn.new("black",@parse_hash[x]+"7")}

    @board[7][0]=Rook.new("white","a1")
    @board[7][1]=Knight.new("white","b1")
    @board[7][2]=Bishop.new("white","c1")
    @board[7][3]=Queen.new("white","d1")
    @board[7][4]=King.new("white","e1")
    @board[7][5]=Bishop.new("white","f1")
    @board[7][6]=Knight.new("white","g1")
    @board[7][7]=Rook.new("white","h1")
    8.times {|x| @board[6][x]=Pawn.new("white",@parse_hash[x]+"2")}

  end

  def valid_tile?(tile)
    return false unless tile.length==2
    return false unless [tile[0]].any? {|x| ["a","b","c","d","e","f","g","h"].include?(x)}
    return false unless (tile[1].to_i>0 and tile[1].to_i<9)
    true
  end
  def parse_tile(tile) "EX: a1 -> [7,0]"
    x_pos = @parse_hash.key(tile[0])
    y_pos = 8-tile[1].to_i
    [[y_pos] , [x_pos] ]
  end
end


class Piece
  attr_reader :position, :color
  def initialize(color,position)
    @color=color
    @position=position
    @symbol=""
  end

  public
  def update_pos(new_pos)
    @position=new_pos
  end
  def to_s
    return @symbol
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

game = Chess.new
game.play()