require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/identify_straight.rb'

class TestIdentifyStraight < Minitest::Test
  def test_hand_identifies_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 6)
    identify_straight = IdentifyStraight.new(straight_hand)
    assert_equal identify_straight.straight?, true
  end
end
