require 'lib/pokerscore/hand.rb'
require 'lib/pokerscore/card.rb'


### ----- Change card values here ----- ###

CARDS1 = [
  Card.new(13, :club),
  Card.new(12, :club),
  Card.new(11, :club),
  Card.new(10, :club),
  Card.new(9, :club)
]

CARDS2 = [
  Card.new(14, :diamond),
  Card.new(14, :spade),
  Card.new(11, :diamond),
  Card.new(11, :spade),
  Card.new(8, :club)
]

 ### ----- Don't need to change anything below this line ----- ###

HAND1 = Hand.new(CARDS1)
HAND2 = Hand.new(CARDS2)

puts "\n"
puts "Hand 1: #{HAND1.to_s}"
puts "Hand 2: #{HAND2.to_s}"
puts "\n"

puts "Hand 1 has a #{HAND1.bestcards}"
puts "Hand 2 has a #{HAND2.bestcards}"
puts "\n"

case HAND1 <=> HAND2
when 1
  puts "Hand 1 wins!"
when 0
  puts "It's a tie!"
when -1
  puts "Hand 2 wins!"
end

puts "\n"
