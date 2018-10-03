require 'const/hand_constants.rb'
require 'lib/pokerscore/set.rb'

class Hand
  attr_reader :cards
  WHEEL_STRAIGHT = [2,3,4,5,14]

  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
  end

  def sets
    sets = []
    unique_values = cards.map(&:value).uniq
    unique_values.each do |unique_value|
      occurrances = cards.count { |card| card.value == unique_value }
      sets << Set.new(unique_value, occurrances)
    end
    sets
  end

  def max_value
    cards.max { |card1, card2| card1.value <=> card2.value }.value
  end

  def straight?
    sorted_values = cards.map(&:value).sort
    return true if sorted_values == WHEEL_STRAIGHT
    sorted_values.each_cons(2).each do |value, next_value|
      return false if not value == next_value - 1
    end
    true
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|card| [card.suit, card.value]}
    unique_cards.length != 5
  end

  def flush?
    cards.map(&:suit).uniq.length == 1
  end

  def to_s
    cards.map(&:to_s).join(", ")
  end
end
