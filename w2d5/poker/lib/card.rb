class Card
  VALUES = {
    ace: 14,
    king: 13,
    queen: 12,
    jack: 11,
    ten: 10,
    nine: 9,
    eight: 8,
    seven: 7,
    six: 6,
    five: 5,
    four: 4,
    three: 3,
    two: 2
  }

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }



  attr_reader :name, :suit

  def initialize(name, suit)
    @name = name
    @suit = suit

    unless self.class.names.include?(name) || self.class.suits.include?(suit)
      raise ArgumentError.new "Invalid card name or suit"
    end
  end

  def render
    "#{name} of #{SUIT_STRINGS[suit]}"
  end

  def value
    VALUES[name]
  end

  def self.names
    VALUES.keys
  end

  def self.suits
    [:hearts, :diamonds, :clubs, :spades]
  end
end
