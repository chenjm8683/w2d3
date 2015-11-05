require_relative 'card'
 class Deck
   attr_accessor :cards
   def initialize
     @cards = []
     build_deck!
   end

   def build_deck!
     @cards = []
     suits = {0=>:s, 1=>:h, 2=>:d, 3=>:c}
     (0..51).to_a.shuffle.each do |num|
       @cards << Card.new(suits[num / 13], (num % 13) + 1)
     end
   end


 end
