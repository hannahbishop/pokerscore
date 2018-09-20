require 'lib/pokerscore/card.rb'
require 'lib/pokerscore/hand.rb'

class Scorer
  attr_reader :winner
  def initialize(cards1, cards2)
    restriction = "Hands must not contain the same cards"
    cards1.each do |c| 
      raise ArgumentError.new(restriction) if cards2.include?(c)
    end

    @hand1 = Hand.new(cards1)
    @hand2 = Hand.new(cards2)
    @winner = find_winner
  end

  def find_winner
    case @hand1 <=> @hand2
    when 1
      return @hand1.cards
    when 0
      return nil
    when -1
      return @hand2.cards
    end
  end

  def print_detailed_score
      puts "\n"
      puts "Hand 1: #{@hand1.to_s}"
      puts "Hand 2: #{@hand2.to_s}"
      puts "\n"

      puts "Hand 1 has a #{@hand1.bestcards}"
      puts "Hand 2 has a #{@hand2.bestcards}"
      puts "\n"

      case @winner
      when @hand1
        puts "Hand 1 wins!"
      when nil
        puts "It's a tie!"
      when @hand2
        puts "Hand 2 wins!"
      end
  end
end
