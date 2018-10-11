require 'minitest/autorun'
require 'minitest/color'
require 'lib/pokerscore/compare_hand_types'
require 'tests/hand_factories'

class TestCompareHandTypes < MiniTest::Test
  extend Minitest::Spec::DSL

  let(:compare) { CompareHandTypes.new }

  def test_compare_hand_types_finds_winner
    winner = HandFactories::full_house_hand(4,2)
    loser = HandFactories::high_card_hand(9)
    assert_equal compare.call(winner, loser), winner
  end

  def test_compare_hand_types_finds_tie
    hand = HandFactories::high_card_hand(12)
    assert_nil compare.call(hand, hand)
  end
end
