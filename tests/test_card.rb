require 'minitest/autorun'
require 'minitest/color'
require 'lib/pokerscore/card.rb'
require 'const/card_constants.rb'

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

  def test_two_card_objects_with_same_fields_are_equal
    card1 = Card.new(2, :heart)
    card2 = Card.new(2, :heart)
    assert_equal card1, card2
  end

  def test_two_card_objects_with_different_fields_are_inequal
    different_value1 = Card.new(3, :heart)
    different_value2 = Card.new(2, :heart)

    different_suit1 = Card.new(3, :heart)
    different_suit2 = Card.new(3, :club)

    refute_equal different_value1, different_value2
    refute_equal different_suit1, different_suit2
  end

  def test_card_to_string_method_displays_human_readable_card_description
    card = Card.new(4, :heart)
    assert_equal card.to_s, "4 hearts"
  end

  def test_card_to_string_method_converts_face_cards_to_readable_format
    ace = Card.new(14, :club)
    king = Card.new(13, :diamond)
    queen = Card.new(12, :spade)
    jack = Card.new(11, :heart)
    
    assert_equal ace.to_s, "A clubs"
    assert_equal king.to_s, "K diamonds"
    assert_equal queen.to_s, "Q spades"
    assert_equal jack.to_s, "J hearts"

  end

end
