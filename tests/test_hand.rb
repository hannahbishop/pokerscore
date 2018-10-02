require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'

class TestHand < Minitest::Test
  def test_hand_identifies_sets
    full_house_hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    assert_equal full_house_hand.sets.length, 2
  end

  def test_hand_identifies_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 6)
    assert_equal straight_hand.straight?, true
  end

  def test_hand_identifies_high_card
    hand = HandFactories.straight_hand(high_card_value = 11)
    assert_equal hand.max_value, 11
  end
end
