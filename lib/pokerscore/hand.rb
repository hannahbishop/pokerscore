require './const/hand_constants.rb'

class Hand
  include Comparable
  attr_reader :cards, :straight, :sets, :bestcards

  def <=>(hand2)
    if bestcards != hand2.bestcards
      return $hand_types[bestcards] <=> $hand_types[hand2.bestcards]
    end
    values = []
    hand2_values = []
    (1..4).each { |index| values += sets[index].sort }
    (1..4).each { |index| hand2_values += hand2.sets[index].sort }
    values.each_with_index do |value, index|
      return value <=> hand2_values[index] if value != hand2_values[index]
    end
    return values.last <=> hand2_values.last
  end

  def to_s 
    cards.map{|card| card.to_s}.join(", ")
  end
  
  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
    @straight = find_straight(cards)
    @sets = find_sets(cards)
    @bestcards = find_best_cards(cards)
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|card| [card.suit, card.value]}
    unique_cards.length != 5
  end

  def flush?
    flush = true
    cards.each do |card|
      flush = false if card.suit != cards.first.suit
    end
    flush
  end

  private


  def find_straight(cards)
    sorted = cards.sort_by { |card| card.value }
    range = (sorted.first.value..sorted.last.value)
    sorted.each_cons(2).each do |card, next_card|
      range = nil if not card.value == next_card.value - 1
    end
    range
  end

  def find_sets(cards)
    sets = Hash.new { |hash, key| hash[key] = [] }
    unique_values = cards.uniq{ |card| card.value }.map{ |card| card.value }
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
    best = :straight if straight != nil and !flush
    best = :flush if flush
    best = :full_house if sets[3].length == 1 and sets[2].length == 1
    best = :four_of_a_kind if sets[4].length == 1 
    if flush
      best = :straight_flush if straight != nil
      best = :royal_flush if straight == (10..14)
    end
    return best
  end
end 
