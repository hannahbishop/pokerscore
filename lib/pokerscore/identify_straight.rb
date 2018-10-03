WHEEL_STRAIGHT = [2,3,4,5,14]

module IdentifyStraight
  def self.straight?(hand)
      sorted_values = hand.cards.map(&:value).sort
      return true if sorted_values == WHEEL_STRAIGHT
      sorted_values.each_cons(2).each do |value, next_value|
        return false if not value == next_value - 1
      end
      true
  end
end
