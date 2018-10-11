module TexasHoldEm
  class HandValues
    @@values = {
      :high_card => 1,
      :pair => 2,
      :two_pair => 3,
      :three_of_a_kind => 4,
      :straight => 5,
      :flush => 6,
      :full_house => 7,
      :four_of_a_kind => 8,
      :straight_flush => 9,
      :royal_flush => 10
    }

    def self.get_value(hand_type)
      @@values.fetch(hand_type)
    end
  end
end
