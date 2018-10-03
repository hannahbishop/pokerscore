require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/identify_sets.rb'

class TestIdentifySets < Minitest::Test
  def test_hand_identifies_sets
    full_house_hand = HandFactories.full_house_hand(triplet = 5, pair = 2)
    assert_equal IdentifySets.sets(full_house_hand).length, 2
  end
end