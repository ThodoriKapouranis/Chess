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