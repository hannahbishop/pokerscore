require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories'
require 'lib/pokerscore/quad_search'

class TestQuadSearch < MiniTest::Test
  def test_quad_search_finds_quads
    hand = HandFactories.four_of_a_kind_hand(4)
    assert PokerScore::QuadSearch.new.call(hand).size, 1
  end
end
