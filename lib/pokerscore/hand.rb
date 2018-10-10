class Hand
  attr_reader :cards

  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
  end

  def max_value
    cards.max { |card1, card2| card1.value <=> card2.value }.value
  end

  def to_s
    cards.map(&:to_s).join(", ")
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|card| [card.suit, card.value]}
    unique_cards.length != 5
  end
end
