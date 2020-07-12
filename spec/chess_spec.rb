require './lib/chess.rb'

describe Piece do
  describe '#new' do
    it "Creates correct color" do
      pawn = Pawn.new("white","a1")
      expect(pawn.symbol).to eql("♙")
    end
  end
end