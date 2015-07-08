class TexasHoldEm
  VALID_CARDS = %w{2C 3C 4C 5C 6C 7C 8C 9C 10C JC QC KC AC 2S 3S 4S 5S 6S 7S 8S 9S 10S JS QS KS AS 2D 3D 4D 5D 6D 7D 8D 9D 10D JD QD KD AD 2H 3H 4H 5H 6H 7H 8H 9H 10H JH QH KH AH}

  VALID_RANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  VALID_SUITS = %w{C S D H}

  def initialize(card_string)
    @cards = card_string.split(" ").map { |card| Card.new(card) }

    raise ArgumentError if @cards.size != 7

    raise ArgumentError if @cards.map(&:to_s).uniq != @cards.map(&:to_s)
  end
  
  def best_hand
    possible_hands = @cards.combination(5).to_a

    possible_hands.each do |hand|
      evaluate_hand(hand)
    end
    # for each hand, evaluate its rank
    # choose the best hand
  end

  def evaluate_hand(hand)
    ranks = hand.map(&:rank)
    puts "ranks: #{ranks}"

    highest_rank = 0
    ranks.each do |rank|
      if VALID_RANKS.find_index(rank) > highest_rank
        highest_rank = VALID_RANKS.find_index(rank)
      end
    end

    {
      rank: 10,
      description: "High Card (#{VALID_RANKS[highest_rank]} high)"
    }

    #
    # duplicates = ranks.find_all {|rank| ranks.count(rank) > 1 }
    # puts "duplicates: #{duplicates}"
    #
    # {
    #     rank: 9,
    #     description: "Two of a Kind (#{duplicates[0]} high)"
    # }
  end
end


class Hand
  def initialize(playing_hand, extra_cards)
    @playing_hand = playing_hand
    @extra_cards = extra_cards
  end
end


class Card
  VALID_RANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  VALID_SUITS = %w{C S D H}

  attr_reader :suit, :rank

  def initialize(card_string)
    @suit = card_string.slice!(-1,1)
    @rank = card_string

    raise ArgumentError unless VALID_RANKS.include? rank
    raise ArgumentError unless VALID_SUITS.include? suit
  end

  def to_s
    rank + suit
  end
end