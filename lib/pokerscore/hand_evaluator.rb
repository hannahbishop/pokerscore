require 'lib/pokerscore/identify_straight'
require 'lib/pokerscore/identify_flush'
require 'lib/pokerscore/identify_sets'

module HandEvaluator

  def self.winner(hand1, hand2)
    winner = compare_hand_types(hand1, hand2)
    return winner if winner != nil
    winner = compare_straights(hand1, hand2)
    return winner if winner != nil
    winner = compare_sets(hand1, hand2)
    return winner if winner != nil
  end

  def self.identify(hand)
    num_pairs = IdentifySets.sets(hand).count { |set| set.pair? }
    num_trips = IdentifySets.sets(hand).count { |set| set.trip? }
    num_quads = IdentifySets.sets(hand).count { |set| set.quad? }
    straight = IdentifyStraight.straight?(hand)
    flush = IdentifyFlush.flush?(hand)

    best = :high_card
    best = :pair if num_pairs == 1
    best = :two_pair if num_pairs == 2
    best = :three_of_a_kind if num_trips == 1
    best = :straight if straight and !flush
    best = :flush if flush
    best = :full_house if num_trips == 1 and num_pairs == 1
    best = :four_of_a_kind if num_quads == 1
    if flush
      best = :straight_flush if straight
      best = :royal_flush if straight and hand.max_value == 14
    end
    best
  end

  private

  def self.compare_hand_types(hand1, hand2)
    case $hand_types[identify(hand1)] <=> $hand_types[identify(hand2)]
    when 1
      hand1
    when 0
      nil
    when -1
      hand2
    end
  end

  def self.compare_sets(hand1, hand2)
    hand1_set_values = set_values_in_rank_order(hand1)
    hand2_set_values = set_values_in_rank_order(hand2)
    loop do
      break if hand1_set_values.length == 0
      case hand1_set_values.shift <=> hand2_set_values.shift
      when 1
        return hand1
      when -1
        return hand2
      end
    end
  end

  def self.compare_straights(hand1, hand2)
    case straight_high_card(hand1) <=> straight_high_card(hand2)
    when 1
      hand1
    when 0
      nil
    when -1
      hand2
    end
  end

  def self.straight_high_card(hand)
    sorted_values = hand.cards.map(&:value).sort
    high_card = sorted_values.last
    high_card = 5 if sorted_values == [2,3,4,5,14]
    high_card
  end

  def self.set_values_in_rank_order(hand)
    quads = IdentifySets.sets(hand).select(&:quad?).map(&:value).sort
    trips = IdentifySets.sets(hand).select(&:trip?).map(&:value).sort
    pairs = IdentifySets.sets(hand).select(&:pair?).map(&:value).sort
    singles = IdentifySets.sets(hand).select(&:single?).map(&:value).sort
    quads + trips + pairs + singles
  end
end
