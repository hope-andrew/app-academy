require 'rspec'
require 'hand'
require 'deck'

RSpec.describe Hand do

  subject(:hand) {Hand.new( Deck.new.take(5))}

  let(:one_pairs) do
    [Hand.new([
      Card.new(:eight, :diamond),
      Card.new(:eight, :spades),
      Card.new(:seven, :hearts),
      Card.new(:ten,   :spades),
      Card.new(:queen, :clubs)
    ]),
    Hand.new([
      Card.new(:eight, :hearts),
      Card.new(:eight, :clubs),
      Card.new(:ace,   :hearts),
      Card.new(:two,   :spades),
      Card.new(:jack,  :clubs)
    ]),
    Hand.new([
      Card.new(:nine, :hearts),
      Card.new(:nine, :clubs),
      Card.new(:four, :clubs),
      Card.new(:three,:spades),
      Card.new(:king, :clubs)
    ])]
  end

  let(:three_of_a_kind) do
    Hand.new([
      Card.new(:six,   :hearts),
      Card.new(:six,   :clubs),
      Card.new(:six,   :diamonds),
      Card.new(:five,  :spades),
      Card.new(:seven, :clubs)
    ])
  end

  let(:high_card) do
    Hand.new([
      Card.new(:two,   :hearts),
      Card.new(:eight, :clubs),
      Card.new(:six,   :diamonds),
      Card.new(:ace,   :spades),
      Card.new(:jack,  :clubs)
    ])
  end

  describe "#initialize" do
    it "doesn't raise an error" do
      expect{ Hand.new([]) }.to_not raise_error
    end
  end

  describe "#best_hand" do

    it "recognizes one pair" do
      expect(one_pairs[0].best_hand).to eq [:one_pair, one_pairs[0].cards.first(2)]
      expect(one_pairs[1].best_hand).to eq [:one_pair, one_pairs[1].cards.first(2)]
      expect(one_pairs[2].best_hand).to eq [:one_pair, one_pairs[2].cards.first(2)]
    end

    it "recognizes three of a kind" do
      expect(three_of_a_kind.best_hand).to eq [:three_of_a_kind, three_of_a_kind.cards.first(3)]
    end

    it "recognizes high card" do
      expect(high_card.best_hand).to eq [:high_card, [high_card.cards[3]]]
    end
  end

  describe "#beats?" do
    it "compares two different categories" do
      one_pairs.each do |one_pair|
        expect(three_of_a_kind.beats?(one_pair)).to eq true
      end
    end

    context "when comparing the same hand category" do
      it "tie breaks" do
        expect(one_pairs[2].beats?(one_pairs[1])).to eq true
      end

      it "tie breaks a tie break" do
        expect(one_pairs[1].beats?(one_pairs[0])).to eq true
      end
    end
  end

end
#
# [5, 11, 2]
# [4, 10, 5, 4, 3]
