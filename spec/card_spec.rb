require 'card'

describe Card do
  subject { Card.new(:s, 5) }

  describe '#initialize' do
    it 'creates a Card obj with specific suit and number' do
      expect([subject.suit, subject.number]).to eq([:s, 5])
    end
  end
end
