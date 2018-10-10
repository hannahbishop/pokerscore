require 'lib/pokerscore/set_factories'

module PokerScore
  class TripSearch

    def call(hand)
      trips = hand.cards.group_by(&:value).select { |_, cards| cards.size == 3 }
      trips.map { |trip| PokerScore::SetFactories::trip(trip) }
    end
  end
end
