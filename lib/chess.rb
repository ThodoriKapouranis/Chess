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
    @board.each_with_index {|row,index| print (8-index).to_s+" "+row.join(" ")+"\n"}
    print "0 a b c d e f g h\n\n"
  end

  def make_move(from,to) #Expecting "a4"-like notation
    from_y = parse_tile(from)[0].join.to_i  # [6] -> 6
    from_x = parse_tile(from)[1].join.to_i
    to_y   = parse_tile(to)[0].join.to_i
    to_x   = parse_tile(to)[1].join.to_i

    if @board[from_y][from_x]=="☐"
      p "invalid starting tile"
      return false
    else
      allowable_moves = @board[from_y][from_x].check_moves(@board)
    end

    if allowable_moves.include?([to_y,to_x])
      @board[to_y][to_x]= @board[from_y][from_x]
      @board[to_y][to_x].update_pos(to_y,to_x)
      @board[from_y][from_x]="☐"
      return [to_y,to_x]
    else
      return false
    end

    
  end
  
  def default_board_start
    @board[0][0]=Rook.new("black",[0,0])
    @board[0][1]=Knight.new("black",[0,1])
    @board[0][2]=Bishop.new("black",[0,2])
    @board[0][3]=Queen.new("black",[0,3])
    @board[0][4]=King.new("black",[0,4])
    @board[0][5]=Bishop.new("black",[0,5])
    @board[0][6]=Knight.new("black",[0,6])
    @board[0][7]=Rook.new("black",[0,7])
    8.times {|x| @board[1][x]=Pawn.new("black",[1,x])}

    @board[7][0]=Rook.new("white",[7,0])
    @board[7][1]=Knight.new("white",[7,1])
    @board[7][2]=Bishop.new("white",[7,2])
    @board[7][3]=Queen.new("white",[7,3])
    @board[7][4]=King.new("white",[7,4])
    @board[7][5]=Bishop.new("white",[7,5])
    @board[7][6]=Knight.new("white",[7,6])
    @board[7][7]=Rook.new("white",[7,7])
    8.times {|x| @board[6][x]=Pawn.new("white",[6,x])}

  end

  private
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
  attr_reader :position, :color, :symbol
  def initialize(color,position)
    @color=color
    @position=position
    @symbol=""
    @valid_moves=[]
  end

  public
  def update_pos(y_pos,x_pos)
    @position=[y_pos,x_pos]
  end

  def to_s
    return @symbol
  end

  private
  def is_bound?(num) #bound within the tiles of the game
    if (num>-1 and num<8)
      return true
    else
      return false
    end
  end

  def pawn_movement(board)
    cur_y=@position[0]
    cur_x=@position[1]
    @valid_moves=[]
    if ( @direction=="up" && cur_y!=0)

      if (board[cur_y-1][cur_x]=="☐")   #Move forward
        @valid_moves.push([cur_y-1,cur_x]) 
      end

      if (cur_y==6 && board[cur_y-2][cur_x]=="☐") #Move
        @valid_moves.push([cur_y-2,cur_x])
      end

      if (is_bound?(cur_x-1) && board[cur_y-1][cur_x-1]!="☐") #NW attack
        @valid_moves.push([cur_y-1,cur_x-1])
      end

      if (is_bound?(cur_x+1) && board[cur_y-1][cur_x+1]!="☐") #NE attack
        @valid_moves.push([cur_y-1,cur_x+1])
      end
    end

    if (@direction=="down" && cur_y!=7)
      if ( board[cur_y+1][cur_x]=="☐")
        @valid_moves.push([cur_y+1,cur_x])
      end

      if (cur_y==1 && board[cur_y+2][cur_x]=="☐")
        @valid_moves.push([cur_y+2,cur_x])  
      end

      if (is_bound?(cur_x-1) && board[cur_y+1][cur_x-1]!="☐") #SW
        @valid_moves.push([cur_y+1,cur_x-1])
      end

      if (is_bound?(cur_x+1) && board[cur_y+1][cur_x+1]!="☐") #SE
        @valid_moves.push([cur_y+1,cur_x+1])
      end

    end
    @valid_moves
  end  

  def bishop_movement(board)
    piece=board[@position[0]][@position[1]]
    cur_y=@position[0]
    cur_x=@position[1]
    @valid_moves=[]

    # North East
    cur_y=@position[0]
    cur_x=@position[1]
    until (cur_y<=0 or cur_x>=7)
      if (board[cur_y-1][cur_x+1]!="☐")       
        @valid_moves.push([cur_y-1,cur_x+1]) if (board[cur_y-1][cur_x+1].color!=piece.color)
        break
      end
      @valid_moves.push([cur_y-1,cur_x+1])
      cur_x+=1
      cur_y-=1
    end

    # North West
    cur_y=@position[0]
    cur_x=@position[1]
    until (cur_y<=0 or cur_x<=0)
      if (board[cur_y-1][cur_x-1]!="☐")                #Upon hitting a piece, 
        @valid_moves.push([cur_y-1,cur_x-1]) if (board[cur_y-1][cur_x-1].color!=piece.color)
        break
      end
      @valid_moves.push([cur_y-1,cur_x-1]) 
      cur_x-=1
      cur_y-=1
    end

    #South East
    cur_y=@position[0]
    cur_x=@position[1]
    until (cur_y>=7 or cur_x>=7)
      if (board[cur_y+1][cur_x+1]!="☐")                #Upon hitting a piece, 
        @valid_moves.push([cur_y+1,cur_x+1]) if (board[cur_y+1][cur_x+1].color!=piece.color)
        break
      end
      @valid_moves.push([cur_y+1,cur_x+1]) 
      cur_x+=1
      cur_y+=1
    end

    #South West
    cur_y=@position[0]
    cur_x=@position[1]
    until (cur_y>=7 or cur_x<=0)
      if (board[cur_y+1][cur_x-1]!="☐")                #Upon hitting a piece, 
        @valid_moves.push([cur_y+1,cur_x-1]) if (board[cur_y+1][cur_x-1].color!=piece.color)
        break
      end
      @valid_moves.push([cur_y+1,cur_x-1]) 
      cur_x-=1
      cur_y+=1
    end
  @valid_moves
  end  

  def rook_movement(board)
    piece=board[@position[0]][@position[1]]
    @valid_moves=[]

    cur_y=@position[0]
    cur_x=@position[1]
    until cur_x<=0 #Check left
      if (board[cur_y][cur_x-1]!="☐")
        @valid_moves.push([cur_y,cur_x-1]) if board[cur_y][cur_x-1].color!=piece.color
        break
      end     
      @valid_moves.push([cur_y,cur_x-1])
      cur_x-=1
    end    

    cur_y=@position[0]
    cur_x=@position[1]
    until cur_x>=7 #Check right
      if (board[cur_y][cur_x+1]!="☐")
        @valid_moves.push([cur_y,cur_x+1]) if board[cur_y][cur_x+1].color!=piece.color
        break
      end     
      @valid_moves.push([cur_y,cur_x+1])
      cur_x+=1
    end

    cur_y=@position[0]
    cur_x=@position[1]
    until cur_y>=7 #Check down
      if (board[cur_y+1][cur_x]!="☐")
        @valid_moves.push([cur_y+1,cur_x]) if board[cur_y+1][cur_x].color!=piece.color
        break
      end     
      @valid_moves.push([cur_y+1,cur_x])
      cur_y+=1
    end

    cur_y=@position[0]
    cur_x=@position[1]
    until cur_y<=0 #Check up
      if (board[cur_y-1][cur_x]!="☐")
        @valid_moves.push([cur_y-1,cur_x]) if board[cur_y-1][cur_x].color!=piece.color
        break
      end     
      @valid_moves.push([cur_y-1,cur_x])
      cur_y-=1
    end
    @valid_moves
  end


end

class Pawn < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♙" if @color.downcase=="white"
    @symbol="♟︎" if @color.downcase=="black"
    @direction="up" if @color.downcase=="white"
    @direction="down" if @color.downcase=="black"
  end

  def check_moves(board)
    pawn_movement(board)
  end
end

class Knight < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♘" if @color.downcase=="white"
    @symbol="♞" if @color.downcase=="black"
  end
  def check_moves
  
  end
end

class Bishop < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♗" if @color.downcase=="white"
    @symbol="♝" if @color.downcase=="black"
  end
  def check_moves(board)
    bishop_movement(board)
  end

end

class Rook < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♖" if @color.downcase=="white"
    @symbol="♜" if @color.downcase=="black"
  end
  def check_moves(board)
    rook_movement(board)
  end
end

class Queen < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♕" if @color.downcase=="white"
    @symbol="♛" if @color.downcase=="black"
  end
  def check_moves(board)
    rook_movement(board)+bishop_movement(board)
  end
end

class King < Piece
  def initialize(color, position)
    super(color,position)
    @symbol="♔" if @color.downcase=="white"
    @symbol="♚" if @color.downcase=="black"
  end
  def check_moves
  
  end
end
