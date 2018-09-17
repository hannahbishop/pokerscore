class Hand
  attr_reader :cards
  
  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|c| [c.suit, c.value]}
    unique_cards.length != 5
  end
end 