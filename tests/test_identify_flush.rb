require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'
require 'lib/pokerscore/identify_flush.rb'

class TestIdentifyStraight < Minitest::Test
  def test_hand_identifies_flush
    flush_hand = HandFactories.flush_hand(high_card_value = 6)
    assert_equal IdentifyFlush.flush?(flush_hand), true
  end
end
