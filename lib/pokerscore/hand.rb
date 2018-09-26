require './const/hand_constants.rb'

class Hand
  include Comparable
  attr_reader :cards, :straight_high_card, :sets, :bestcards

  def <=>(hand2)
    if bestcards != hand2.bestcards
      return $hand_types[bestcards] <=> $hand_types[hand2.bestcards]
    end
    if straight_high_card != nil
      return straight_high_card <=> hand2.straight_high_card 
    end
    values = 4.downto(1).map { |index| sets[index].sort }
    hand2_values = 4.downto(1).map { |index| hand2.sets[index].sort }
    values.zip(hand2_values).each do |value, hand2_value|
      return value <=> hand2_value if value != hand2_value
    end
  end

  def to_s 
    cards.map(&:to_s).join(", ")
  end
  
  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
    @straight_high_card = find_straight(cards)
    @sets = find_sets(cards)
    @bestcards = find_best_cards(cards)
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|card| [card.suit, card.value]}
    unique_cards.length != 5
  end

  def flush?
    cards.map(&:suit).uniq.length == 1
  end

  private


  def find_straight(cards)
    sorted_values = cards.map(&:value).sort
    result = sorted_values.last
    sorted_values.each_cons(2).each do |value, next_value|
      result = nil if not value == next_value - 1
    end
    result = 5 if sorted_values == [2,3,4,5,14] # wheel straight
    result
  end

  def find_sets(cards)
    sets = Hash.new { |hash, key| hash[key] = [] }
    unique_values = cards.map(&:value).uniq
    unique_values.each do |unique_value|
      occurrances = cards.count { |card| card.value == unique_value }
      sets[occurrances] << unique_value
    end
    sets
  end

  def find_best_cards(cards)
    flush = flush?
    best = :high_card
    best = :pair if sets[2].length == 1
    best = :two_pair if sets[2].length == 2
    best = :three_of_a_kind if sets[3].length == 1
    best = :straight if straight_high_card != nil and !flush
    best = :flush if flush
    best = :full_house if sets[3].length == 1 and sets[2].length == 1
    best = :four_of_a_kind if sets[4].length == 1 
    if flush
      best = :straight_flush if straight_high_card != nil
      best = :royal_flush if straight_high_card == 14
    end
    return best
  end
end 
