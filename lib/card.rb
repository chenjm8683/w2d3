class Card
  attr_reader :suit, :number
  def initialize(suit, number)
    @suit = suit
    @number = number
    #status?
  end

  def same_card?(card)
    return @suit == card.suit && @number == card.number
  end




end
# ♣♦♥♠

# c1 = Card.new(:s, 5)
# c2 = Card.new(:s, 5)
