require 'lib/pokerscore/pair'
require 'lib/pokerscore/trip'
require 'lib/pokerscore/quad'

module PokerScore
  module SetFactories

    def self.pair(cards)
      Pair.new(cards)
    end

    def self.trip(cards)
      Trip.new(cards)
    end

    def self.quad(cards)
      Quad.new(cards)
    end

  end
end
