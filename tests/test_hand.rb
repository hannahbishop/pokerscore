require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'

class TestHand < Minitest::Test
  def test_hand_identifies_highest_value
    hand = HandFactories.straight_hand(high_card_value = 11)
    assert_equal hand.max_value, 11
  end
end
