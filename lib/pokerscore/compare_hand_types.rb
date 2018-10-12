require 'lib/pokerscore/texas_hold_em/identify'

class CompareHandTypes

  def initialize(hand_values)
    @hand_values = hand_values
  end

  def call(hand1, hand2)
    identify = TexasHoldEm::Identify.new
    value1 = @hand_values.get_value(identify.call(hand1))
    value2 = @hand_values.get_value(identify.call(hand2))
    case value1 <=> value2
    when 1
      hand1
    when 0
      nil
    when -1
      hand2
    end
  end
end
