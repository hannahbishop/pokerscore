require 'lib/pokerscore/card.rb'
require 'lib/pokerscore/scorer.rb'

### ----- Edit the cards below ----- ###

CARDS1 = [
  Card.new(2, :heart),
  Card.new(2, :diamond),
  Card.new(4, :heart),
  Card.new(5, :heart),
  Card.new(7, :club)
]

CARDS2 = [
  Card.new(2, :club),
  Card.new(2, :spade),
  Card.new(4, :club),
  Card.new(5, :club),
  Card.new(8, :heart)
]

### ----- No need to change anything below this line ----- ###

scorer = Scorer.new(CARDS1, CARDS2)
scorer.print_detailed_score
