require 'lib/pokerscore/hand.rb'
require 'lib/pokerscore/card.rb'

module HandFactories
  def self.hand(values)
    Hand.new([
      Card.new(values.pop, :heart),
      Card.new(values.pop, :club),
      Card.new(values.pop, :spade),
      Card.new(values.pop, :diamond),
      Card.new(values.pop, :heart)
    ])
  end

  def self.royal_flush_hand
    Hand.new([
      Card.new(14, :heart),
      Card.new(13, :heart),
      Card.new(12, :heart),
      Card.new(11, :heart),
      Card.new(10, :heart)
    ])
  end

  def self.straight_flush_hand(high_card_value)
    possible_card_values = (2..high_card_value).to_a
    Hand.new([
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart)
    ])
  end

  def self.four_of_a_kind_hand(four_of_a_kind_value)
    remaining_card_values = (2..14).to_a - [four_of_a_kind_value]
    Hand.new([
      Card.new(four_of_a_kind_value, :heart),
      Card.new(four_of_a_kind_value, :club),
      Card.new(four_of_a_kind_value, :spade),
      Card.new(four_of_a_kind_value, :diamond),
      Card.new(remaining_card_values.pop, :heart)
    ])
  end

  def self.full_house_hand(triplet_value, pair_value)
    Hand.new([
      Card.new(triplet_value, :heart),
      Card.new(triplet_value, :club),
      Card.new(triplet_value, :spade),
      Card.new(pair_value, :heart),
      Card.new(pair_value, :club)
    ])
  end

  def self.flush_hand(high_card_value) 
    possible_card_values = (2..high_card_value).to_a
    Hand.new([
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.shift, :heart)
    ])
  end

  def self.straight_hand(high_card_value)
    possible_card_values = (2..high_card_value).to_a
    Hand.new([
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :heart),
      Card.new(possible_card_values.pop, :club)
    ])
  end

  def self.triplet_hand(triplet_value)
  remaining_card_values = (2..14).to_a - [triplet_value]
  Hand.new([
    Card.new(triplet_value, :heart),
    Card.new(triplet_value, :club),
    Card.new(triplet_value, :spade),
    Card.new(remaining_card_values.pop, :heart),
    Card.new(remaining_card_values.pop, :heart)
  ])
  end

  def self.two_pair_hand(pair_value1, pair_value2)
    remaining_card_values = (2..14).to_a - [pair_value1, pair_value2]
    Hand.new([
      Card.new(pair_value1, :heart),
      Card.new(pair_value1, :club),
      Card.new(pair_value2, :spade),
      Card.new(pair_value2, :diamond),
      Card.new(remaining_card_values.pop, :heart)
    ])
  end

  def self.pair_hand(pair_value)
    remaining_card_values = (2..14).to_a - [pair_value]
    Hand.new([
      Card.new(pair_value, :heart),
      Card.new(pair_value, :club),
      Card.new(remaining_card_values.pop, :heart),
      Card.new(remaining_card_values.pop, :heart),
      Card.new(remaining_card_values.pop, :heart)
    ])
  end

  def self.high_card_hand(high_card_value)
    remaining_card_values = (2...high_card_value).to_a
    Hand.new([
      Card.new(high_card_value, :heart),
      Card.new(remaining_card_values.pop, :heart),
      Card.new(remaining_card_values.pop, :heart),
      Card.new(remaining_card_values.pop, :heart),
      Card.new(remaining_card_values.shift, :club)
    ])
  end
end
