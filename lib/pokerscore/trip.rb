class Trip

  def initialize(cards)
    @cards = cards
  end

  def value
    @cards.first.value
  end

end
