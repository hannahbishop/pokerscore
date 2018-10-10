require 'lib/pokerscore/set_factories'

module PokerScore
  class QuadSearch

    def call(hand)
      quads = hand.cards.group_by(&:value).select { |_, cards| cards.size == 4 }
      quads.map { |quad| PokerScore::SetFactories::quad(quad) }
    end
  end
end
