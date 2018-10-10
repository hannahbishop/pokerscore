require 'lib/pokerscore/identify_straight'
require 'lib/pokerscore/identify_flush'
require 'lib/pokerscore/pair_search'
require 'lib/pokerscore/trip_search'
require 'lib/pokerscore/quad_search'

module TexasHoldEm
  class Identify

    def initialize(hand)
      @hand = hand
      @pairs = PokerScore::PairSearch.new.call(@hand)
      @trips = PokerScore::TripSearch.new.call(@hand)
      @quads = PokerScore::QuadSearch.new.call(@hand)
      @has_flush = IdentifyFlush.new(hand).call
      @has_straight = IdentifyStraight.new(hand).call
    end

    def call
      num_pairs = @pairs.size
      num_trips = @trips.size
      num_quads = @quads.size

      best = :high_card
      best = :pair if num_pairs == 1
      best = :two_pair if num_pairs == 2
      best = :three_of_a_kind if num_trips == 1
      best = :straight if @has_straight and !@has_flush
      best = :flush if @has_flush
      best = :full_house if num_trips == 1 and num_pairs == 1
      best = :four_of_a_kind if num_quads == 1
      if @has_flush
        best = :straight_flush if @has_straight
        best = :royal_flush if @has_straight and @hand.max_value == 14
      end
      best
    end
  end
end
