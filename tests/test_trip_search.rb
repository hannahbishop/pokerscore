require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories'
require 'lib/pokerscore/trip_search'

class TestTripSearch < MiniTest::Test
  def test_trip_search_finds_trips
    hand = HandFactories.triplet_hand(4)
    assert PokerScore::TripSearch.new.call(hand).size, 1
  end
end
