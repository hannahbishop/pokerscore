require 'minitest/autorun'
require 'minitest/color'
require 'lib/pokerscore/set'

class TestSet < MiniTest::Test
  def test_set_can_be_a_single
    single = Set.new(3, 1)
    assert_equal single.single?, true
  end

  def test_set_can_be_a_pair
    pair = Set.new(5, 2)
    assert_equal pair.pair?, true
  end

  def test_set_can_be_a_trip
    trip = Set.new(6, 3)
    assert_equal trip.trip?, true
  end

  def test_set_can_be_a_quad
    quad = Set.new(7, 4)
    assert_equal quad.quad?, true
  end
end
