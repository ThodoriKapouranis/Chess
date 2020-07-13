require './lib/chess.rb'

describe Piece do
  describe '#new' do
    it "Creates correct color (white)" do
      pawn = Pawn.new("white","a1")
      expect(pawn.symbol).to eql("♙")
    end
    it "Creates correct color (black)" do
      pawn = Pawn.new("black","a1")
      expect(pawn.symbol).to eql("♟︎")
    end
  end
end

describe Pawn do
  describe '#check_moves'do
    it "Does not go past pieces (white)" do
      game = Chess.new
      game.default_board_start
      game.make_move("a2","a3")
      game.make_move("a3","a4")
      game.make_move("a4","a5")
      game.make_move("a5","a6")
      game.display
      expect(game.make_move("a6","a7")).to eql(false)
    end
    it "Does not go past pieces (black)" do
      game = Chess.new
      game.default_board_start
      game.make_move("a7","a6")
      game.make_move("a6","a5")
      game.make_move("a5","a4")
      game.make_move("a4","a3")
      game.display
      expect(game.make_move("a3","a2")).to eql(false)
    end
    it "Can take NE" do
      game = Chess.new
      game.default_board_start
      game.make_move("a2","a3")
      game.make_move("a3","a4")
      game.make_move("a4","a5")
      game.make_move("a5","a6")
      expect(game.make_move("a6","b7")).to eql([1,1])
      game.display
    end
    it "Can take NW" do
      game = Chess.new
      game.default_board_start
      game.make_move("h2","h3")
      game.make_move("h3","h4")
      game.make_move("h4","h5")
      game.make_move("h5","h6")
      expect(game.make_move("h6","g7")).to eql([1,6])
      game.display
    end
    it "Can take SW" do
      game = Chess.new
      game.default_board_start
      game.make_move("h7","h6")
      game.make_move("h6","h5")
      game.make_move("h5","h4")
      game.make_move("h4","h3")
      expect(game.make_move("h3","g2")).to eql([6,6])
      game.display
    end
    it "Can take SE" do
      game = Chess.new
      game.default_board_start
      game.make_move("a7","a6")
      game.make_move("a6","a5")
      game.make_move("a5","a4")
      game.make_move("a4","a3")
      expect(game.make_move("a3","b2")).to eql([6,1])
      game.display
    end
    it "Can move two from starting position (white)" do
      game = Chess.new
      game.default_board_start
      expect(game.make_move("a2","a4")).to eql([4,0])
      game.display
    end

    it "Can move two from starting position (black)" do
      game = Chess.new
      game.default_board_start
      expect(game.make_move("a7","a5")).to eql([3,0])
      game.display
    end

  end
end

describe Bishop do
  describe '#check_moves' do
    it "can move move diagonally all NE NW SE SW" do
      game = Chess.new
      game.default_board_start
      game.make_move('g2','g3')
      game.make_move('f1','h3')
      game.make_move('h3','d7')
      game.make_move('d7','a4')
      game.make_move('a4','b3')
      expect(game.make_move('b3','f7')).to eql([1,5])
      game.display
    end
  end
end

describe Rook do
  describe "#check_move" do
    it "Allows cardinal movement" do
      game = Chess.new
      game.default_board_start
      game.make_move("a2","a4")
      game.make_move("a1","a3")
      game.make_move("a3","h3")
      game.make_move("h3","h4")
      game.make_move("h4","b4")
      game.make_move("b4","b7")
      expect(game.make_move("b7","b2")).to eql(false)
      game.display
    end
  end
end