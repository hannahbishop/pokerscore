require 'minitest/autorun'
require 'minitest/color'
require 'tests/hand_factories.rb'

class TestHand < Minitest::Test

  def test_hand_sets_straight_high_card_to_nil_if_does_not_contain_straight
    no_straight = HandFactories.pair_hand(pair_value = 4)
    assert_nil no_straight.straight_high_card
  end

  def test_hand_sets_straight_high_card_if_contains_straight
    straight_hand = HandFactories.straight_hand(high_card_value = 7)
    assert_equal straight_hand.straight_high_card, 7
  end
    
  def test_hand_flush_defaults_to_nil
    no_flush_hand = HandFactories.high_card_hand(high_card_value = 9)
    assert_equal no_flush_hand.flush?, false
  end

  def test_hand_flush_is_true_if_hand_contains_flush
    flush_hand = HandFactories.flush_hand(high_card_value = 10)
    assert_equal flush_hand.flush?, true
  end

  def test_hand_can_recognize_pair
    pair_hand = HandFactories.pair_hand(pair_value = 3)
    assert_equal pair_hand.sets[2], [3]
  end

  def test_hand_can_recognize_two_pair
    two_pair = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    assert_equal two_pair.sets[2], [3,5]
  end

  def test_hand_can_recognize_triplet
    triplet_hand = HandFactories.triplet_hand(triplet_value = 5)
    assert_equal triplet_hand.sets[3], [5]
  end

  def test_hand_can_recognize_full_house
    full_house_hand = HandFactories.full_house_hand(triplet_value = 5, pair_value = 3)
    assert_equal full_house_hand.sets[2], [3]
    assert_equal full_house_hand.sets[3], [5]
  end

  def test_hand_can_recognize_four_of_a_kind
    four_of_a_kind_hand = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 5)
    assert_equal four_of_a_kind_hand.sets[4], [5]
  end

  def assert_best_cards_name(cards, name)
    hand = Hand.new(cards)
    assert_equal hand.bestcards, name
  end

  def test_hand_correctly_labels_its_best_cards_as_a_high_card
    high_card = HandFactories.high_card_hand(high_card_value = 13)
    assert_equal high_card.bestcards, :high_card
  end

  def test_hand_correctly_labels_its_best_cards_as_a_pair
    pair = HandFactories.pair_hand(pair_value = 10)
    assert_equal pair.bestcards, :pair
  end

  def test_hand_correctly_labels_its_best_cards_as_two_pairs
    two_pair = HandFactories.two_pair_hand(pair_value1 = 3, pair_value2 = 5)
    assert_equal two_pair.bestcards, :two_pair
  end
  
  def test_hand_correctly_labels_its_best_cards_as_three_of_a_kind
    three_of_a_kind = HandFactories.triplet_hand(triplet_value = 6)
    assert_equal three_of_a_kind.bestcards, :three_of_a_kind
  end

  def test_hand_correctly_labels_its_best_cards_as_full_house
    full_house = HandFactories.full_house_hand(triplet_value = 3, pair_value = 2)
    assert_equal full_house.bestcards, :full_house
  end

  def test_hand_correctly_labels_its_best_cards_as_four_of_a_kind
    four_of_a_kind = HandFactories.four_of_a_kind_hand(four_of_a_kind_value = 6)
    assert_equal four_of_a_kind.bestcards, :four_of_a_kind
  end

  def test_hand_correctly_labels_its_best_cards_as_royal_flush
    royal_flush = HandFactories.royal_flush_hand
    assert_equal royal_flush.bestcards, :royal_flush
  end

  def test_hand_correctly_labels_its_best_cards_as_straight_flush
    straight_flush = HandFactories.straight_flush_hand(high_card_value = 10)
    assert_equal straight_flush.bestcards, :straight_flush
  end

  def test_hand_correctly_labels_its_best_cards_as_straight
    straight = HandFactories.straight_hand(high_card_value = 6)
    assert_equal straight.bestcards, :straight
  end

  def test_hand_with_wheel_straight_correctly_labels_its_best_cards_as_straight
    wheel_straight = HandFactories.hand([2,3,4,5,14])
    assert_equal wheel_straight.bestcards, :straight
  end

  def test_hand_correctly_labels_its_best_cards_as_flush
    flush = HandFactories.flush_hand(high_card = 7)
    assert_equal flush.bestcards, :flush
  end

  def test_compare_operator_is_accurate_when_best_cards_are_different_type
    flush = HandFactories.flush_hand(high_card_value = 10)
    straight = HandFactories.straight_hand(high_card_value = 7)
    assert flush > straight
    assert straight < flush
  end

  def test_compare_operator_is_accurate_when_best_cards_are_tied
    straight1 = HandFactories.straight_hand(high_card_value = 13)
    straight2 = HandFactories.straight_hand(high_card_value = 13)
    assert_equal straight1, straight2
  end

  def test_compare_operator_wheel_straight_is_less_than_other_straights
    wheel_straight = HandFactories.hand([2,3,4,5,14])
    straight = HandFactories.straight_hand(high_card_value = 10)
    assert wheel_straight < straight
  end 
end
