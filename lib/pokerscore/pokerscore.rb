require 'lib/pokerscore/card.rb'
require 'lib/pokerscore/scorer.rb'

CARDS1 = [
  Card.new(13, :club),
  Card.new(12, :club),
  Card.new(11, :club),
  Card.new(10, :club),
  Card.new(9, :club)
]

CARDS2 = [
  Card.new(13, :heart),
  Card.new(14, :spade),
  Card.new(10, :diamond),
  Card.new(11, :spade),
  Card.new(8, :club)
]

scorer = Scorer.new(CARDS1, CARDS2)
scorer.print_detailed_score
