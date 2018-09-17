require File.expand_path('../../const/card_constants.rb', __FILE__)

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

  def ==(other_card)
    result = other_card.class == Card 
    result = result && other_card.suit == suit
    result = result && other_card.value == value
    result
  end
end