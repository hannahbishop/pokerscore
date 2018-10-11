require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/texas_hold_em/identify.rb'

class TestIdentify < Minitest::Test
  extend Minitest::Spec::DSL

  let(:identify) { TexasHoldEm::Identify.new }
  subject { identify.call(hand) }

  def test_identify_finds_pair
    hand = HandFactories.pair_hand(pair_value = 10)
    assert_equal identify.call(hand), :pair
  end

  def test_identify_finds_two_pair
    hand = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    assert_equal identify.call(hand), :two_pair
  end

  def test_identify_finds_trips
    hand = HandFactories.triplet_hand(triplet_value = 6)
    assert_equal identify.call(hand), :three_of_a_kind
  end

  def test_identify_finds_full_house
    hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    assert_equal identify.call(hand), :full_house
  end

  def test_identify_finds_quad
    hand = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 6)
    assert_equal identify.call(hand), :four_of_a_kind
  end

  def test_identify_finds_royal_flush
    hand = HandFactories.royal_flush_hand
    assert_equal identify.call(hand), :royal_flush
  end

  def test_identify_finds_straight_flush
    hand = HandFactories.straight_flush_hand(high_card_value = 10)
    assert_equal identify.call(hand), :straight_flush
  end

  def test_identify_finds_straight
    hand = HandFactories.straight_hand(high_card_value = 6)
    assert_equal identify.call(hand), :straight
  end

  def test_identify_finds_straight_from_wheel_straight
    hand = HandFactories.hand([2,3,4,5,14])
    assert_equal identify.call(hand), :straight
  end

  def test_identify_finds_flush
    hand = HandFactories.flush_hand(high_card = 7)
    assert_equal identify.call(hand), :flush
  end
end
