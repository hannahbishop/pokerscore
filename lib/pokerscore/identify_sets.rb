module IdentifySets
  def self.sets(hand)
    sets = []
    unique_values = hand.cards.map(&:value).uniq
    unique_values.each do |unique_value|
      occurrances = hand.cards.count { |card| card.value == unique_value }
      sets << Set.new(unique_value, occurrances)
    end
    sets
  end
end
