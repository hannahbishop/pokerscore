require 'minitest/autorun'
require 'minitest/color'
require File.expand_path('../../lib/card.rb', __FILE__)

class TestCard < Minitest::Test
    def test_can_create_card_object
        card = Card.new
        assert_equal card.class, Card
    end 
end