require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories'
require 'lib/pokerscore/texas_hold_em/evaluate'

class TestEvaluate < Minitest::Test
  def test_evaluate_finds_winner_from_different_hand_types
    flush = HandFactories.flush_hand(high_card_value = 10)
    straight = HandFactories.straight_hand(high_card_value = 7)
    evaluate = TexasHoldEm::Evaluate.new(flush, straight)
    assert_equal evaluate.call, flush
  end

  def test_evaluate_finds_tie_and_returns_nil
    trips1 = HandFactories.hand([2,2,2,5,6])
    trips2 = HandFactories.hand([2,2,2,5,6])
    evaluate = TexasHoldEm::Evaluate.new(trips1, trips2)
    assert_nil evaluate.call
  end

  def test_evaluate_finds_winner_wheel_straight_vs_straight
    wheel_straight = HandFactories.hand([2,3,4,5,14])
    straight = HandFactories.straight_hand(high_card_value = 6)
    evaluate = TexasHoldEm::Evaluate.new(wheel_straight, straight)
    assert_equal evaluate.call, straight
  end

  def test_evaluate_finds_winner_sets_vs_sets
    two_pair1 = HandFactories.two_pair_hand(pair_value1 = 5, pair_value2 = 3)
    two_pair2 = HandFactories.two_pair_hand(pair_value1 = 5, pair_value2 = 2)
    evaluate = TexasHoldEm::Evaluate.new(two_pair1, two_pair2)
    assert_equal evaluate.call, two_pair1
  end
end
