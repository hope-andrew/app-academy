require 'rspec'
require 'deck'

RSpec.describe Deck do
  subject(:deck) { Deck.new() }
  let(:suits) { [ :hearts, :diamonds, :clubs, :spades ] }

  describe "#initialize" do
    it "should initialize with a full deck of cards" do
      expect(deck.count).to eq 52
    end

    it "should include 13 of each suit" do
      suits.each do |suit|
        expect(deck.cards.count{|card| card.suit == suit}).to eq 13
      end
    end
  end

  describe "#cards" do

    it "returns an array of cards" do
      expect(deck.cards).to be_a Array
      deck.cards.each do |card|
        expect(card).to be_a Card
      end
    end

  end

  describe "#shuffle" do

    it "should have the same number of cards" do
      deck.shuffle
      expect(deck.count).to be 52
    end

    it "should change the order of cards" do
      deck.cards.sort_by!(&:value)
      deck.shuffle
      expect(deck.cards).to_not eq deck.cards.sort_by(&:value)
    end

  end

  describe "#take" do

    it "should return a card" do
      first_card = [deck.cards.first]
      expect(deck.take(1)).to eq first_card
    end

    it "should remove the card from the deck" do
      first_card = deck.take(1).first
      expect(deck.cards.include?(first_card)).to be_falsey
      expect(deck.count).to eq 51
    end

    it "should take multiple cards" do
      first_three = deck.cards.first(3)
      expect(deck.take(3)).to eq first_three
      expect(deck.count).to eq 49
    end
  end

  describe "#count" do
    it "should return the number of cards in the deck" do
      expect(deck.count).to eq deck.cards.count
    end

  end

end
