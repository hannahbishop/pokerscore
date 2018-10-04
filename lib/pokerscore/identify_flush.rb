class IdentifyFlush

  def initialize(hand)
    @hand = hand
  end

  def flush?
    @hand.cards.map(&:suit).uniq.length == 1
  end
end
