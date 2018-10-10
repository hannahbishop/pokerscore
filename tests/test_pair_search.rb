require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories'
require 'lib/pokerscore/pair_search'

class TestPairSearch < MiniTest::Test
  def test_pair_search_finds_pairs
    hand = HandFactories.pair_hand(4)
    assert PokerScore::PairSearch.new.call(hand).size, 1
  end
end
