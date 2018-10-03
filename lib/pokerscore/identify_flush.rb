module IdentifyFlush
  def self.flush?(hand)
    hand.cards.map(&:suit).uniq.length == 1
  end
end
