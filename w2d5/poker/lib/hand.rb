require 'card'
require 'byebug'

class Hand
  attr_reader :cards

  def categories
    [ :straight_flush,
      :four_of_a_kind,
      :full_house,
      :flush,
      :straight,
      :three_of_a_kind,
      :two_pair,
      :one_pair,
      :high_card
    ]
  end

  def initialize(cards)
    @cards = cards
  end

  def best_hand
    categories.each do |category|
      result = self.send("#{category}?")
      return [category, result] if result
    end


    # if flush = straight_flush?
    #   [:straight_flush, flush]
    # elsif four = four_of_a_kind?
    #   [:four_of_a_kind, four]
    # elsif full_house = full_house?
    #   [:full_house, full_house]
    # elsif flush = flush?
    #   [:flush, flush]
    # elsif straight = straight?
    #   [:straight, straight]
    # elsif three = three_of_a_kind?
    #   [:three_of_a_kind, three]
    # elsif two_pair = two_pair?
    #   [:two_pair, two_pair]
    # elsif one_pair = one_pair?
    #   [:one_pair, one_pair]
    # else
    #   [:high_card, [sort.first]]
    # end
  end

  def beats?(other_hand)

  end


  private

  def sort
    cards.sort_by(&:value).reverse
  end

  def straight_flush?
    (straight? && flush?) ? sort : false
  end

  def full_house?
    of_a_kind?(3) && of_a_kind?(2)
  end

  def straight?
    sorted_cards = sort
    straight = (0...cards.length-1).all? do |i|
      sorted_cards[i].value - sorted_cards[i+1].value == 1
    end
    straight ? sort : false
  end

  def flush?
    cards.all? { |card| card.suit == cards.first.suit } ? sort : false
  end

  def of_a_kind?(n)
    counts = Hash.new(0)
    cards.each { |card| counts[card.name] += 1 }
    if name = counts.key(n)
      cards.select { |card| card.name == name }
    else
      false
    end
  end

  def four_of_a_kind?
    of_a_kind?(4)
  end

  def three_of_a_kind?
    of_a_kind?(3)
  end

  def one_pair?
    of_a_kind?(2)
  end

  def two_pair?
    # fix later
    cards.map(&:name).uniq.count == 3
  end

  def high_card?
    [sort.first]
  end

end
