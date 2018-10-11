require 'const/hand_constants'
require 'lib/pokerscore/texas_hold_em/identify'

class CompareHandTypes
  def call(hand1, hand2)
    identify = TexasHoldEm::Identify.new
    hand1_type = $hand_types[identify.call(hand1)]
    hand2_type = $hand_types[identify.call(hand2)]
    case hand1_type <=> hand2_type
    when 1
      hand1
    when 0
      nil
    when -1
      hand2
    end
  end
end
