require 'rspec'
require 'towers_of_hanoi'

RSpec.describe TowersOfHanoiGame do
  subject(:game) {TowersOfHanoiGame.new}

  describe "#initialize" do
    it "initializes with default stacks" do
      expect(game.stacks).to eq([[3,2,1], [], []])
    end

    it "initializes with passed stacks" do
      stacks = [[4,3,2,1], [], []]
      new_game = TowersOfHanoiGame.new(stacks)
      expect(new_game.stacks).to eq stacks
    end
  end

  describe "#move" do

    it "performs moves properly" do
      game.move(0, 1)
      expect(game.stacks).to eq([[3,2], [1], []])
    end

    context "when moving a larger disk on a smaller disk" do
      it "raises an error" do
        game.move(0, 1)
        expect { game.move(0, 1) }.to raise_error(InvalidMoveError)
      end
    end

    context "when moving from an empty stack" do
      it "raises an error" do
        expect { game.move(1,2) }.to raise_error(InvalidMoveError)
      end
    end
  end

  describe "#won?" do
    context "tower has moved to a new stack" do
      it "should win on second stack" do
        game.stacks = [[],[3,2,1],[]]
        expect(game).to be_won
      end

      it "should win on third stack" do
        game.stacks = [[],[], [3,2,1]]
        expect(game).to be_won
      end
    end

    context "tower is not in a winning position" do
      it "should return false" do
        game.stacks = [[],[3],[2,1]]
        expect(game).to_not be_won
      end
    end
  end

  describe "#render" do
    it "has a render method" do
      expect{game.render}.to_not raise_error
    end
  end

end
