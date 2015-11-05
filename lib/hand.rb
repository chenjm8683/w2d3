
class Hand
  attr_reader :cards_held
  def initialize
    @cards_held = []
    @hand_hash = {}
  end

  def retrieve(card)
    @cards_held << card

  end

  def rank
    build_hash!
  end

  def flush?
    suits = @hand_hash.keys
    return suits.uniq.length == 1
  end

  def straight?
    numbers = @hand_hash.values.flatten.sort
    if numbers == [1, 10, 11, 12, 13]
      true
    else
      return (numbers[0]..numbers[0]+4).to_a == numbers
    end
  end

  # def straight_flush?
  #   flush? && straight?
  # end

  def four_of_a_kind?
    numbers = @hand_hash.values.flatten.sort
    return numbers.count(numbers[0]) == 4 || numbers.count(numbers[1]) == 4
  end

  def three_of_a_kind?
    numbers = @hand_hash.values.flatten.sort
    return  numbers.count(numbers[0]) == 3 ||
      numbers.count(numbers[1]) == 3 ||
      numbers.count(numbers[2]) == 3
  end

  def one_pair?
    @hand_hash.values.flatten.uniq.length == 4
  end

  def two_pair?
    @hand_hash.values.flatten.sort.uniq.length == 3 && !three_of_a_kind?
  end

  def full_house?
    return three_of_a_kind? && @hand_hash.values.flatten.uniq.length == 2
  end


  # def

  def build_hash!
    @hand_hash = Hash.new { |h, k| h[k] = []}
    @cards_held.each do |card|
      @hand_hash[card.suit] << card.number
    end
  end



end
