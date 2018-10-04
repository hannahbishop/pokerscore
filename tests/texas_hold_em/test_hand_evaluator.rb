require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/texas_hold_em/hand_evaluator.rb'

class TestHand < Minitest::Test
  def test_hand_evaluator_accurately_compares_different_hand_types
    flush = HandFactories.flush_hand(high_card_value = 10)
    straight = HandFactories.straight_hand(high_card_value = 7)
    assert_equal HandEvaluator::winner(flush, straight), flush
  end

  def test_hand_evaluator_accurately_finds_tie_and_returns_nil
    trips1 = HandFactories.hand([2,2,2,5,6])
    trips2 = HandFactories.hand([2,2,2,5,6])
    assert_nil HandEvaluator::winner(trips1, trips2)
  end

  def test_hand_evaluator_accurately_finds_winner_wheel_straight_vs_straight
    wheel_straight = HandFactories.hand([2,3,4,5,14])
    straight = HandFactories.straight_hand(high_card_value = 6)
    assert_equal HandEvaluator::winner(wheel_straight, straight), straight
  end

  def test_hand_evaluator_accurately_finds_winner_sets_vs_sets
    two_pair1 = HandFactories.two_pair_hand(pair_value1 = 5, pair_value2 = 3)
    two_pair2 = HandFactories.two_pair_hand(pair_value1 = 5, pair_value2 = 2)
    assert_equal HandEvaluator::winner(two_pair1, two_pair2), two_pair1
  end
end
