require 'lib/pokerscore/set_factories'

module PokerScore
  class PairSearch

    def call(hand)
      pairs = hand.cards.group_by(&:value).select { |_, cards| cards.size == 2 }
      pairs.map { |pair| PokerScore::SetFactories::pair(pair) }
    end
  end
end
