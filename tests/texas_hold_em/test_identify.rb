require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/texas_hold_em/identify.rb'

class TestHand < Minitest::Test

  def test_hand_evaluator_identifies_pair
    pair_hand = HandFactories.pair_hand(pair_value = 10)
    identify_pair_hand = TexasHoldEm::Identify.new(pair_hand)
    assert_equal identify_pair_hand.identify, :pair
  end

  def test_hand_evaluator_identifies_two_pair
    two_pair_hand = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    identify_two_pair_hand = TexasHoldEm::Identify.new(two_pair_hand)
    assert_equal identify_two_pair_hand.identify, :two_pair
  end

  def test_hand_evaluator_identifies_trips
    trips_hand = HandFactories.triplet_hand(triplet_value = 6)
    identify_trips_hand = TexasHoldEm::Identify.new(trips_hand)
    assert_equal identify_trips_hand.identify, :three_of_a_kind
  end

  def test_hand_evaluator_identifies_full_house
    full_house_hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    identify_full_house_hand = TexasHoldEm::Identify.new(full_house_hand)
    assert_equal identify_full_house_hand.identify, :full_house
  end

  def test_hand_evaluator_identifies_quad
    quad_hand = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 6)
    identify_quad_hand = TexasHoldEm::Identify.new(quad_hand)
    assert_equal identify_quad_hand.identify, :four_of_a_kind
  end

  def test_hand_evaluator_identifies_royal_flush
    royal_flush_hand = HandFactories.royal_flush_hand
    identify_royal_flush_hand = TexasHoldEm::Identify.new(royal_flush_hand)
    assert_equal identify_royal_flush_hand.identify, :royal_flush
  end

  def test_hand_evaluator_identifies_straight_flush
    straight_flush_hand = HandFactories.straight_flush_hand(high_card_value = 10)
    identify_straight_flush_hand = TexasHoldEm::Identify.new(straight_flush_hand)
    assert_equal identify_straight_flush_hand.identify, :straight_flush
  end

  def test_hand_evaluator_identifies_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 6)
    identify_straight_hand = TexasHoldEm::Identify.new(straight_hand)
    assert_equal identify_straight_hand.identify, :straight
  end

  def test_hand_evaluator_identifies_straight_from_wheel_straight
    wheel_straight_hand = HandFactories.hand([2,3,4,5,14])
    identify_wheel_straight_hand = TexasHoldEm::Identify.new(wheel_straight_hand)
    assert_equal identify_wheel_straight_hand.identify, :straight
  end

  def test_hand_evaluator_identifies_flush
    flush_hand = HandFactories.flush_hand(high_card = 7)
    identify_flush_hand = TexasHoldEm::Identify.new(flush_hand)
    assert_equal identify_flush_hand.identify, :flush
  end
end
