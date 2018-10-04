class IdentifySets

  def initialize(hand)
    @hand = hand
  end

  def sets
    sets = []
    unique_values = @hand.cards.map(&:value).uniq
    unique_values.each do |unique_value|
      occurrences = @hand.cards.count { |card| card.value == unique_value }
      sets << Set.new(unique_value, occurrences)
    end
    sets
  end
end
