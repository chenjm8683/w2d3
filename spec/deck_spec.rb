require 'deck'

describe Deck do
  subject { Deck.new }

  describe '#initialize' do
    it 'creates a Deck obj with shuffled 52 cards' do
      expect(subject.cards.length).to eq(52)
      expect(subject.cards[rand(52)]).to be_an_instance_of(Card)
    end

    it 'does not have duplicate cards' do
      duplicate = false
      subject.cards.each_with_index do |card1, idx1|
        subject.cards.each_with_index do |card2, idx2|
          next if idx2 <= idx1
          duplicate = true if card1.same_card?(card2)
          break if duplicate
        end
      end
      expect(duplicate).to eq(false)
    end
  end

  

end
