require 'minitest/autorun'
require 'minitest/color'
require 'lib/pokerscore/hand.rb'
require 'lib/pokerscore/card.rb'

class TestHand < Minitest::Test
  VALID_CARDS = [
    Card.new(3, :heart),
    Card.new(5, :spade),
    Card.new(12, :club),
    Card.new(14, :diamond),
    Card.new(2, :heart)
  ]

  def test_can_create_hand_class
    hand = Hand.new(VALID_CARDS)
    assert_equal hand.class, Hand
  end

  def test_creating_hand_class_initializes_cards
    hand = Hand.new(VALID_CARDS)
    assert_equal hand.cards, VALID_CARDS
  end

  def test_hand_class_requires_exactly_five_cards
    too_many_cards = VALID_CARDS + [Card.new(6, :diamond)]
    too_few_cards = VALID_CARDS[1...5]

    assert_raises ArgumentError do 
      hand = Hand.new(too_many_cards)
    end
    assert_raises ArgumentError do
      hand = Hand.new(too_few_cards)
    end
  end

  def test_hand_class_will_not_accept_duplicate_cards
    duplicate_cards = [
      Card.new(3, :heart), #duplicate
      Card.new(2, :spade),
      Card.new(3, :club),
      Card.new(4, :diamond),
      Card.new(3, :heart) #duplicate
    ]
    
    assert_raises ArgumentError do
      hand = Hand.new(duplicate_cards)
    end
  end

  def test_hand_can_recognize_mixed_suit_non_straight_cards
    hand = Hand.new(VALID_CARDS)
    assert_nil hand.straight[:range]
    assert_equal hand.straight[:suit], :mixed
  end

  def test_hand_can_recognize_mixed_suit_straight_cards
    mixed_straight = [
      Card.new(3, :heart),
      Card.new(4, :spade),
      Card.new(5, :club),
      Card.new(6, :diamond),
      Card.new(7, :heart)
    ]
    hand = Hand.new(mixed_straight)
    assert_equal hand.straight[:suit], :mixed
  end
    
  def test_hand_can_recognize_same_suit_straight_cards
    heart_straight = [
      Card.new(3, :heart),
      Card.new(4, :heart),
      Card.new(5, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    hand = Hand.new(heart_straight)
    assert_equal hand.straight[:suit], :heart
  end

  def test_hand_can_recognize_a_pair
    contains_pair = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    hand = Hand.new(contains_pair)
    assert_equal hand.sets[1], [5,6,7]
    assert_equal hand.sets[2], [3]
    assert_equal hand.sets[3], []
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_two_pair
    contains_two_pair = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(7, :heart)
    ]
    hand = Hand.new(contains_two_pair)
    assert_equal hand.sets[1], [7]
    assert_equal hand.sets[2], [3,5]
    assert_equal hand.sets[3], []
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_a_triplet
    contains_two_pair = [
      Card.new(3, :heart),
      Card.new(7, :club),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_two_pair)
    assert_equal hand.sets[1], [3,7]
    assert_equal hand.sets[2], []
    assert_equal hand.sets[3], [5]
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_a_pair_and_triplet
    contains_two_pair = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_two_pair)
    assert_equal hand.sets[1], []
    assert_equal hand.sets[2], [3]
    assert_equal hand.sets[3], [5]
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_a_quadruplet
    contains_two_pair = [
      Card.new(3, :heart),
      Card.new(5, :diamond),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_two_pair)
    assert_equal hand.sets[1], [3]
    assert_equal hand.sets[2], []
    assert_equal hand.sets[3], []
    assert_equal hand.sets[4], [5]
  end

end
