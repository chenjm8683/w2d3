require 'hand'
require 'card'

describe Hand do
  subject { Hand.new }

  describe '#initialize' do
    it 'creates hand with no cards' do
      expect(subject.cards_held).to eq([])
    end
  end

  describe '#retrieve' do
    let(:card) { Card.new(:s, 10) }
    it 'stores a given card from the deck' do
      subject.retrieve(card)
      expect(subject.cards_held).to eq([card])
    end
  end

  describe '#flush?' do

    it 'returns true if hand is flush' do
      [1, 4, 6, 7, 9].each do |num|
        subject.retrieve(Card.new(:s, num))
      end
      subject.build_hash!
      expect(subject.flush?).to eq(true)
    end

    it 'returns false if hand is not flush' do
      [1, 4, 6, 7].each do |num|
        subject.retrieve(Card.new(:s, num))
      end
      subject.retrieve(Card.new(:d, 10))
      subject.build_hash!
      expect(subject.flush?).to eq(false)
    end
  end

  describe '#straight?' do

    it 'returns true if hand is straight' do
      [1, 2, 3, 4, 5].each do |num|
        subject.retrieve(Card.new(:s, num))
      end
      subject.build_hash!
      expect(subject.straight?).to eq(true)
    end

    it 'returns true if hand is back straight' do
      [1, 10, 11, 12, 13].each do |num|
        subject.retrieve(Card.new(:d, num))
      end
      subject.build_hash!
      expect(subject.straight?).to eq(true)
    end

    it 'returns false if hand is not straight' do
      [1, 2, 10, 11, 12].each do |num|
        subject.retrieve(Card.new(:d, num))
      end
      subject.build_hash!
      expect(subject.straight?).to eq(false)
    end
  end

  # describe '#straight_flush?' do
  #
  #   it 'returns true if hand is straight_flush' do
  #     [1, 2, 3, 4, 5].each do |num|
  #       subject.retrieve(Card.new(:s, num))
  #     end
  #     subject.build_hash!
  #     expect(subject.straight_flush?).to eq(true)
  #   end
  #
  #   it 'returns true if hand is back straight' do
  #     [1, 10, 11, 12, 13].each do |num|
  #       subject.retrieve(Card.new(:d, num))
  #     end
  #     subject.build_hash!
  #     expect(subject.straight?).to eq(true)
  #   end
  #
  #   it 'returns false if hand is not straight' do
  #     [1, 2, 10, 11, 12].each do |num|
  #       subject.retrieve(Card.new(:d, num))
  #     end
  #     subject.build_hash!
  #     expect(subject.straight?).to eq(false)
  #   end
  # end

  describe '#four_of_a_kind?' do
    it 'returns true if hand is a four_of_a_kind' do
      [:d, :s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.four_of_a_kind?).to eq(true)
    end

    it 'returns false if hand is not a 4 of a kind' do
      [:d, :s, :c].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 4))
      subject.build_hash!
      expect(subject.four_of_a_kind?).to eq(false)
    end
  end

  describe '#three_of_a_kind?' do
    it 'returns true if hand is a three_of_a_kind' do
      [:d, :s, :c].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 1))
      subject.retrieve(Card.new(:h, 2))
      subject.build_hash!
      expect(subject.three_of_a_kind?).to eq(true)
    end

    it 'returns false if hand is not a 3 of a kind' do
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 7))
      subject.retrieve(Card.new(:s, 4))
      subject.build_hash!
      expect(subject.three_of_a_kind?).to eq(false)
    end

    it 'returns false if hand is 4 of a kind' do
      [:d, :s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.three_of_a_kind?).to eq(false)
    end
  end

  describe '#one_pair?' do
    it 'returns true if hand is a one_pair' do
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 1))
      subject.retrieve(Card.new(:h, 2))
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.one_pair?).to eq(true)
    end

    it 'returns false if hand is not a one_pair' do
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 7))
      subject.retrieve(Card.new(:s, 4))
      subject.retrieve(Card.new(:h, 10))
      subject.retrieve(Card.new(:h, 1))
      subject.build_hash!
      expect(subject.one_pair?).to eq(false)
    end

    it 'returns false if hand is 4 of a kind' do
      [:d, :s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.one_pair?).to eq(false)
    end

    it 'returns false if hand is 3 of a kind' do
      [:d, :s, :c].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 1))
      subject.retrieve(Card.new(:h, 2))
      subject.build_hash!
      expect(subject.one_pair?).to eq(false)
    end
  end

  describe '#two_pair?' do
    it 'returns true if hand is a two_pair' do
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 4))
      end
      subject.retrieve(Card.new(:h, 2))
      subject.build_hash!
      expect(subject.two_pair?).to eq(true)
    end

    it 'returns false if hand is not a two_pair' do
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 7))
      subject.retrieve(Card.new(:s, 4))
      subject.build_hash!
      expect(subject.two_pair?).to eq(false)
    end

    it 'returns false if hand is a 4 of a kind' do
      [:d, :s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.two_pair?).to eq(false)
    end

    it 'returns false if hand is full house' do
      [:s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 5))
      subject.build_hash!
      expect(subject.two_pair?).to eq(false)
    end
  end

  describe '#full_house?' do
    it 'returns false if hand is a two_pair' do
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      [:d, :s].each do |suit|
        subject.retrieve(Card.new(suit, 4))
      end
      subject.retrieve(Card.new(:h, 2))
      subject.build_hash!
      expect(subject.full_house?).to eq(false)
    end

    it 'returns false if hand is a 4 of a kind' do
      [:d, :s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.build_hash!
      expect(subject.full_house?).to eq(false)
    end

    it 'returns true if hand is full house' do
      [:s, :c, :h].each do |suit|
        subject.retrieve(Card.new(suit, 13))
      end
      subject.retrieve(Card.new(:h, 5))
      subject.retrieve(Card.new(:s, 5))
      subject.build_hash!
      expect(subject.full_house?).to eq(true)
    end
  end
end
