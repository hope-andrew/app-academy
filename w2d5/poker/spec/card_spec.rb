require 'rspec'
require 'card'

RSpec.describe Card do
  subject(:card) { Card.new(:eight, :hearts) }

  describe "#initialize" do
    it "sets the suit" do
      expect(card.suit).to eq :hearts
    end

    it "sets the name" do
      expect(card.name).to eq :eight
    end

    context "when given invalid information" do
      it "raises an error" do
        expect { Card.new(:foo, :bar) }.to raise_error
      end
    end
  end

  let(:lower_card) { Card.new(:ten, :hearts) }
  let(:higher_card) { Card.new(:jack, :diamonds) }

  describe "#value" do

    it "should return the proper value" do
      expect(lower_card.value).to eq 10
      expect(higher_card.value).to eq 11
    end

  end

  describe "#render" do 
    it "returns a string" do
      expect(card.render).to be_a String
    end
  end

end
