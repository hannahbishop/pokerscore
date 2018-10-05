require 'lib/pokerscore/identify_sets'
require 'lib/pokerscore/identify_straight'
require 'lib/pokerscore/identify_flush'

module TexasHoldEm
  class Identify

    def initialize(hand)
      @hand = hand
      @identify_sets = IdentifySets.new(hand)
      @identify_flush = IdentifyFlush.new(hand)
      @identify_straight = IdentifyStraight.new(hand)
    end

    def identify
      num_pairs = @identify_sets.sets.count { |set| set.pair? }
      num_trips = @identify_sets.sets.count { |set| set.trip? }
      num_quads = @identify_sets.sets.count { |set| set.quad? }
      straight = @identify_straight.straight?
      flush = @identify_flush.flush?

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
        best = :royal_flush if straight and @hand.max_value == 14
      end
      best
    end
  end
end
