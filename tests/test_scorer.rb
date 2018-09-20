require 'minitest/autorun'
require 'minitest/color'
require 'lib/pokerscore/card.rb'
require 'lib/pokerscore/scorer.rb'

class TestScore < Minitest::Test
  def test_scorer_will_raise_error_if_initialzied_with_duplicate_cards
    cards1 = [
      Card.new(13, :club),
      Card.new(12, :club),
      Card.new(11, :club),
      Card.new(10, :club),
      Card.new(9, :club)
    ]

    cards2 = [
      Card.new(13, :club),
      Card.new(14, :spade),
      Card.new(10, :diamond),
      Card.new(11, :spade),
      Card.new(8, :club)
    ]
    assert_raises ArgumentError do 
      Scorer.new(cards1, cards2)
    end
  end

  def test_scorer_provides_winner
    winner = [
      Card.new(13, :club),
      Card.new(12, :club),
      Card.new(11, :club),
      Card.new(10, :club),
      Card.new(9, :club)
    ]

    loser = [
      Card.new(13, :heart),
      Card.new(13, :spade),
      Card.new(10, :diamond),
      Card.new(11, :spade),
      Card.new(8, :club)
    ]
    scorer = Scorer.new(winner, loser)
    assert_equal scorer.winner, winner
  end

  def test_scorer_correctly_finds_a_tie
    winner = [
      Card.new(13, :club),
      Card.new(12, :club),
      Card.new(11, :club),
      Card.new(10, :club),
      Card.new(9, :club)
    ]

    loser = [
      Card.new(13, :heart),
      Card.new(12, :heart),
      Card.new(10, :heart),
      Card.new(11, :heart),
      Card.new(9, :heart)
    ]
    scorer = Scorer.new(winner, loser)
    assert_nil scorer.find_winner
  end

end
