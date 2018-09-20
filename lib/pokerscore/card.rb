require 'const/card_constants.rb'

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    if $valid_suits.include? suit and $valid_values.include? value
      @suit = suit
      @value = value
    else
      raise ArgumentError, "Invalid card. Given suit #{suit} and value #{value}"
    end
  end

  def to_s
    readable_value = $face_cards.include?(value) ? $face_cards[value] : value
    "#{readable_value} #{suit}s"
  end

  def ==(other_card)
    result = other_card.class == Card 
    result = result && other_card.suit == suit
    result = result && other_card.value == value
    result
  end
end
