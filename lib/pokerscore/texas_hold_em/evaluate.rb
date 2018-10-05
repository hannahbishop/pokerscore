require 'lib/pokerscore/identify_sets'
require 'lib/pokerscore/texas_hold_em/identify'

module TexasHoldEm
  class Evaluate

    def initialize(hand1, hand2)
      @hand1 = hand1
      @hand2 = hand2
      @identify_hand1 = TexasHoldEm::Identify.new(hand1)
      @identify_hand2 = TexasHoldEm::Identify.new(hand2)
    end

    def call
      winner = compare_hand_types
      return winner if winner != nil
      winner = compare_straights
      return winner if winner != nil
      winner = compare_sets
      return winner if winner != nil
    end

    private

    def compare_hand_types
      hand1_type = $hand_types[@identify_hand1.call]
      hand2_type = $hand_types[@identify_hand2.call]
      case hand1_type <=> hand2_type
      when 1
        @hand1
      when 0
        nil
      when -1
        @hand2
      end
    end

    def compare_sets
      hand1_set_values = set_values_in_rank_order(@hand1)
      hand2_set_values = set_values_in_rank_order(@hand2)
      loop do
        break if hand1_set_values.length == 0
        case hand1_set_values.shift <=> hand2_set_values.shift
        when 1
          return @hand1
        when -1
          return @hand2
        end
      end
    end

    def compare_straights
      case straight_high_card(@hand1) <=> straight_high_card(@hand2)
      when 1
        @hand1
      when 0
        nil
      when -1
        @hand2
      end
    end

    def straight_high_card(hand)
      sorted_values = hand.cards.map(&:value).sort
      high_card = sorted_values.last
      high_card = 5 if sorted_values == [2,3,4,5,14]
      high_card
    end

    def set_values_in_rank_order(hand)
      identify_sets = IdentifySets.new(hand)
      quads = identify_sets.call.select(&:quad?).map(&:value).sort
      trips = identify_sets.call.select(&:trip?).map(&:value).sort
      pairs = identify_sets.call.select(&:pair?).map(&:value).sort
      singles = identify_sets.call.select(&:single?).map(&:value).sort
      quads + trips + pairs + singles
    end
  end
end
