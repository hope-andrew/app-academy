require 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card.suits.each do |suit|
      Card.names.each do |name|
        @cards << Card.new(name, suit)
      end
    end
  end

  def shuffle
    cards.shuffle
  end

  def take(num)
    cards.shift(num)
  end

  def count
    cards.count
  end



end
