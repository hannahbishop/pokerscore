require 'lib/pokerscore/identify_sets'
require 'lib/pokerscore/identify_straight'
require 'lib/pokerscore/identify_flush'

module TexasHoldEm
  class Identify

    def initialize(hand)
      @hand = hand
      @sets = IdentifySets.new(hand).call
      @is_flush = IdentifyFlush.new(hand).call
      @is_straight = IdentifyStraight.new(hand).call
    end

    def call
      num_pairs = @sets.count { |set| set.pair? }
      num_trips = @sets.count { |set| set.trip? }
      num_quads = @sets.count { |set| set.quad? }
      straight = @is_straight
      flush = @is_flush

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
