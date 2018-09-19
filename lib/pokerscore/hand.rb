class Hand
  attr_reader :cards, :straight, :sets, :bestcards
  
  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
    @straight = find_straight(cards)
    @sets = find_sets(cards)
    @bestcards = find_best_cards(cards)
  end

  def invalid_hand?(cards)
    unique_cards = cards.uniq {|c| [c.suit, c.value]}
    unique_cards.length != 5
  end

  private

  def find_straight(cards)
    sorted = cards.sort_by { |c| c.value }
    result = { 
      :range => sorted.first.value..sorted.last.value,
      :suit => sorted.first.suit
    }
    sorted.each_cons(2).each do |x,y|
      result[:range] = nil if not x.value == y.value - 1
      result[:suit] = :mixed if not x.suit == y.suit
    end
    result
  end

  def find_sets(cards)
    hash = Hash.new { |h, k| h[k] = [] }
    unique_values = cards.uniq { |c| c.value }
    unique_values.each do |u|
      occurrances = cards.count { |c| c.value == u.value }
      hash[occurrances] << u.value
    end
    hash
  end

  def find_best_cards(cards)
    best = :high_card
    best = :pair if sets[2].length == 1
    best = :two_pair if sets[2].length == 2
    best = :three_of_a_kind if sets[3].length == 1
    best = :straight if straight[:range] != nil and straight[:suit] == :mixed
    best = :flush if cards.each_cons(2).all? { |x,y| x.suit == y.suit }
    best = :full_house if sets[3].length == 1 and sets[2].length == 1
    best = :four_of_a_kind if sets[4].length == 1 
    if straight[:suit] != :mixed
      best = :straight_flush if straight[:range] != nil
      best = :royal_flush if straight[:range] == (10..14)
    end
    return best
  end
end 
