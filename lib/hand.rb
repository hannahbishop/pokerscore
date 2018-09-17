class Hand
  attr_reader :cards, :straight
  
  def initialize(cards)
    raise ArgumentError if invalid_hand?(cards)
    @cards = cards
    @straight = find_straight(cards)
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
end 
