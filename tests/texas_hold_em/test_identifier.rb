require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/texas_hold_em/identifier.rb'

class TestHand < Minitest::Test
  Identifier = TexasHoldEm::Identifier.new()

  def test_hand_evaluator_identifies_pair
    pair_hand = HandFactories.pair_hand(pair_value = 10)
    assert_equal Identifier.identify(pair_hand), :pair
  end

  def test_hand_evaluator_identifies_two_pair
    two_pair_hand = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    assert_equal Identifier.identify(two_pair_hand), :two_pair
  end

  def test_hand_evaluator_identifies_trips
    trips_hand = HandFactories.triplet_hand(triplet_value = 6)
    assert_equal Identifier.identify(trips_hand), :three_of_a_kind
  end

  def test_hand_evaluator_identifies_full_house
    full_house_hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    assert_equal Identifier.identify(full_house_hand), :full_house
  end

  def test_hand_evaluator_identifies_quad
    quad_hand = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 6)
    assert_equal Identifier.identify(quad_hand), :four_of_a_kind
  end

  def test_hand_evaluator_identifies_royal_flush
    royal_flush_hand = HandFactories.royal_flush_hand
    assert_equal Identifier.identify(royal_flush_hand), :royal_flush
  end

  def test_hand_evaluator_identifies_straight_flush
    straight_flush_hand = HandFactories.straight_flush_hand(high_card_value = 10)
    assert_equal Identifier.identify(straight_flush_hand), :straight_flush
  end

  def test_hand_evaluator_identifies_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 6)
    assert_equal Identifier.identify(straight_hand), :straight
  end

  def test_hand_evaluator_identifies_straight_from_wheel_straight
    wheel_straight_hand = HandFactories.hand([2,3,4,5,14])
    assert_equal Identifier.identify(wheel_straight_hand), :straight
  end

  def test_hand_evaluator_identifies_flush
    flush_hand = HandFactories.flush_hand(high_card = 7)
    assert_equal Identifier.identify(flush_hand), :flush
  end
end
