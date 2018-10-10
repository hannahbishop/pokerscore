require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/texas_hold_em/identify.rb'

class TestIdentify < Minitest::Test

  def test_identify_finds_pair
    pair_hand = HandFactories.pair_hand(pair_value = 10)
    identify = TexasHoldEm::Identify.new(pair_hand)
    assert_equal identify.call, :pair
  end

  def test_identify_finds_two_pair
    two_pair_hand = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    identify = TexasHoldEm::Identify.new(two_pair_hand)
    assert_equal identify.call, :two_pair
  end

  def test_identify_finds_trips
    trips_hand = HandFactories.triplet_hand(triplet_value = 6)
    identify = TexasHoldEm::Identify.new(trips_hand)
    assert_equal identify.call, :three_of_a_kind
  end

  def test_identify_finds_full_house
    full_house_hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    identify = TexasHoldEm::Identify.new(full_house_hand)
    assert_equal identify.call, :full_house
  end

  def test_identify_finds_quad
    quad_hand = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 6)
    identify = TexasHoldEm::Identify.new(quad_hand)
    assert_equal identify.call, :four_of_a_kind
  end

  def test_identify_finds_royal_flush
    royal_flush_hand = HandFactories.royal_flush_hand
    identify = TexasHoldEm::Identify.new(royal_flush_hand)
    assert_equal identify.call, :royal_flush
  end

  def test_identify_finds_straight_flush
    straight_flush_hand = HandFactories.straight_flush_hand(high_card_value = 10)
    identify = TexasHoldEm::Identify.new(straight_flush_hand)
    assert_equal identify.call, :straight_flush
  end

  def test_identify_finds_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 6)
    identify = TexasHoldEm::Identify.new(straight_hand)
    assert_equal identify.call, :straight
  end

  def test_identify_finds_straight_from_wheel_straight
    wheel_straight_hand = HandFactories.hand([2,3,4,5,14])
    identify = TexasHoldEm::Identify.new(wheel_straight_hand)
    assert_equal identify.call, :straight
  end

  def test_identify_finds_flush
    flush_hand = HandFactories.flush_hand(high_card = 7)
    identify = TexasHoldEm::Identify.new(flush_hand)
    assert_equal identify.call, :flush
  end
end
