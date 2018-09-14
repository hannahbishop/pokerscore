require 'minitest/autorun'
require 'minitest/color'
require File.expand_path('../../lib/card.rb', __FILE__)
require File.expand_path('../../const/card_constants.rb', __FILE__)

class TestCard < Minitest::Test
  def test_can_create_card_object
    card = Card.new(3, :heart)
    assert_equal card.class, Card
  end
  def test_card_object_has_suit_and_value
    card = Card.new(3, :heart)
    assert_equal card.value, 3
    assert_equal card.suit, :heart
  end
  def test_card_object_rejects_invalid_suit
    assert_raises ArgumentError do
      card = Card.new(3, :hearts)
    end
  end 
  def test_card_object_rejects_value_too_small
    too_small = $valid_values.min - 1
    assert_raises ArgumentError do
      card = Card.new(too_small, :heart)
    end
  end
  def test_card_object_rejects_value_too_large
    too_large = $valid_values.max + 1
    assert_raises ArgumentError do
      card = Card.new(too_large, :heart)
    end
  end
end