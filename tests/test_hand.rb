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

  def test_hand_sets_straight_high_card_to_nil_if_does_not_contain_straight
    hand = Hand.new(VALID_CARDS)
    assert_nil hand.straight_high_card
  end

  def test_hand_sets_straight_high_card_if_contains_straight
    straight = [
      Card.new(3, :heart),
      Card.new(4, :spade),
      Card.new(5, :club),
      Card.new(6, :diamond),
      Card.new(7, :heart)
    ]
    hand = Hand.new(straight)
    assert_equal hand.straight_high_card, 7
  end
    
  def test_hand_flush_defaults_to_nil
    no_flush = [
      Card.new(3, :heart),
      Card.new(4, :spade),
      Card.new(9, :club),
      Card.new(6, :diamond),
      Card.new(7, :heart)
    ]
    hand = Hand.new(no_flush)
    assert_equal hand.flush?, false
  end

  def test_hand_flush_is_true_if_hand_contains_flush
    flush = [
      Card.new(3, :heart),
      Card.new(4, :heart),
      Card.new(9, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    hand = Hand.new(flush)
    assert_equal hand.flush?, true
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
    contains_triplet = [
      Card.new(3, :heart),
      Card.new(7, :club),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_triplet)
    assert_equal hand.sets[1], [3,7]
    assert_equal hand.sets[2], []
    assert_equal hand.sets[3], [5]
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_a_pair_and_triplet
    contains_pair_and_triplet = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_pair_and_triplet)
    assert_equal hand.sets[1], []
    assert_equal hand.sets[2], [3]
    assert_equal hand.sets[3], [5]
    assert_equal hand.sets[4], []
  end

  def test_hand_can_recognize_a_quadruplet
    contains_quadruplet = [
      Card.new(3, :heart),
      Card.new(5, :diamond),
      Card.new(5, :heart),
      Card.new(5, :club),
      Card.new(5, :spade)
    ]
    hand = Hand.new(contains_quadruplet)
    assert_equal hand.sets[1], [3]
    assert_equal hand.sets[2], []
    assert_equal hand.sets[3], []
    assert_equal hand.sets[4], [5]
  end

  def assert_best_cards_name(cards, name)
    hand = Hand.new(cards)
    assert_equal hand.bestcards, name
  end

  def test_hand_correctly_labels_its_best_cards_as_a_high_card
    contains_high_card = [
      Card.new(3, :heart),
      Card.new(4, :club),
      Card.new(6, :heart),
      Card.new(8, :heart),
      Card.new(9, :heart)
    ]
    assert_best_cards_name(contains_high_card, :high_card)
  end

  def test_hand_correctly_labels_its_best_cards_as_a_pair
    contains_pair = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    assert_best_cards_name(contains_pair, :pair)
  end

  def test_hand_correctly_labels_its_best_cards_as_two_pairs
    contains_two_pair = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(6, :heart),
      Card.new(6, :spade),
      Card.new(7, :heart)
    ]
    assert_best_cards_name(contains_two_pair, :two_pair)
  end
  
  def test_hand_correctly_labels_its_best_cards_as_three_of_a_kind
    contains_three_of_a_kind = [
      Card.new(2, :heart),
      Card.new(3, :club),
      Card.new(6, :heart),
      Card.new(6, :spade),
      Card.new(6, :diamond)
    ]
    assert_best_cards_name(contains_three_of_a_kind, :three_of_a_kind)
  end

  def test_hand_correctly_labels_its_best_cards_as_full_house
    contains_full_house = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(6, :heart),
      Card.new(6, :spade),
      Card.new(6, :diamond)
    ]
    assert_best_cards_name(contains_full_house, :full_house)
  end

  def test_hand_correctly_labels_its_best_cards_as_four_of_a_kind
    contains_four_of_a_kind = [
      Card.new(3, :heart),
      Card.new(6, :club),
      Card.new(6, :heart),
      Card.new(6, :spade),
      Card.new(6, :diamond)
    ]
    assert_best_cards_name(contains_four_of_a_kind, :four_of_a_kind)
  end

  def test_hand_correctly_labels_its_best_cards_as_royal_flush
    contains_royal_flush = [
      Card.new(11, :heart),
      Card.new(13, :heart),
      Card.new(14, :heart),
      Card.new(10, :heart),
      Card.new(12, :heart)
    ]
    assert_best_cards_name(contains_royal_flush, :royal_flush)
  end

  def test_hand_correctly_labels_its_best_cards_as_straight_flush
    contains_straight_flush = [
      Card.new(9, :heart),
      Card.new(12, :heart),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    assert_best_cards_name(contains_straight_flush, :straight_flush)
  end

  def test_hand_correctly_labels_its_best_cards_as_straight
    contains_straight = [
      Card.new(9, :heart),
      Card.new(12, :club),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    assert_best_cards_name(contains_straight, :straight)
  end

  def test_hand_with_wheel_straight_correctly_labels_its_best_cards_as_straight
    contains_wheel_straight = [
      Card.new(2, :heart),
      Card.new(4, :club),
      Card.new(3, :heart),
      Card.new(5, :heart),
      Card.new(14, :heart)
    ]
    assert_best_cards_name(contains_wheel_straight, :straight)
  end

  def test_hand_correctly_labels_its_best_cards_as_flush
    contains_flush = [
      Card.new(9, :heart),
      Card.new(3, :heart),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    assert_best_cards_name(contains_flush, :flush)
  end

  def test_compare_operator_is_accurate_when_best_cards_are_different_type
    contains_flush = [
      Card.new(9, :heart),
      Card.new(3, :heart),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    contains_straight = [
      Card.new(9, :heart),
      Card.new(12, :club),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    hand1 = Hand.new(contains_flush)
    hand2 = Hand.new(contains_straight)
    assert hand1 > hand2
    assert hand2 < hand1
  end

  def test_compare_operator_is_accurate_when_best_cards_are_the_same_with_winner
    pair1 = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(5, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    pair2 = [
      Card.new(3, :heart),
      Card.new(3, :club),
      Card.new(4, :heart),
      Card.new(6, :heart),
      Card.new(7, :heart)
    ]
    hand1 = Hand.new(pair1)
    hand2 = Hand.new(pair2)
    assert hand1 > hand2
    assert hand2 < hand1
  end

  def test_compare_operator_is_accurate_when_best_cards_are_tied
    straight1 = [
      Card.new(9, :heart),
      Card.new(12, :club),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    straight2 = [
      Card.new(9, :club),
      Card.new(12, :heart),
      Card.new(13, :club),
      Card.new(11, :club),
      Card.new(10, :club)
    ]
    hand1 = Hand.new(straight1)
    hand2 = Hand.new(straight2)
    assert_equal hand1, hand2
  end

  def test_compare_operator_handles_set_versus_set
    lower_set = [
      Card.new(3, :club),
      Card.new(3, :heart),
      Card.new(3, :spade),
      Card.new(10, :club),
      Card.new(9, :club)
    ]
    higher_set = [
      Card.new(5, :heart),
      Card.new(5, :spade),
      Card.new(5, :diamond),
      Card.new(11, :spade),
      Card.new(8, :club)
    ]
    lower_hand = Hand.new(lower_set)
    higher_hand = Hand.new(higher_set)
    assert lower_hand < higher_hand
  end

  def test_compare_operator_wheel_straight_is_less_than_other_straights
    wheel_straight = [
      Card.new(2, :heart),
      Card.new(3, :club),
      Card.new(4, :heart),
      Card.new(5, :heart),
      Card.new(14, :heart)
    ]
    straight = [
      Card.new(2, :heart),
      Card.new(3, :club),
      Card.new(4, :heart),
      Card.new(5, :heart),
      Card.new(6, :heart)
    ]
    hand1 = Hand.new(wheel_straight)
    hand2 = Hand.new(straight)
    assert hand1 < hand2
  end 

  def test_hand_to_string_returns_all_cards_in_readable_format
    cards = [
      Card.new(9, :heart),
      Card.new(12, :club),
      Card.new(13, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ]
    hand = Hand.new(cards)
    assert_equal hand.to_s, "9 hearts, Q clubs, K hearts, J hearts, 10 hearts"
  end
end
