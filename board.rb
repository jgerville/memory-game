require_relative "card_deck.rb"

class Board  

  attr_accessor :num_remaining_guesses

  def initialize(size)
    raise "Size is not even!" if size.odd?
    @size = size
    @grid = Array.new(size) { Array.new(size, "_") }
    @card_deck = CardDeck.new(("A".."Z").to_a)
    @num_remaining_guesses = ((@size * @size) * 0.75).floor
  end
  
  def populate 
    x = (0..@size - 1).to_a
    y = (0..@size - 1).to_a
    
    card_count = 0
    
    @card_deck.card_values.each do |card_value|
      2.times do 
        position = [y.sample, x.sample]

        until !spot_taken?(position)
          position = [y.sample, x.sample]
        end
        # make sure new coordinates do not overwrite old coords
        @grid[position[0]][position[1]] = card_value # need to make sure every spot is filled
      end
      card_count += 1
      
      break if card_count == (@size * @size) / 2
    end
  end

  def spot_taken?(position)
    row, col = position
    if @grid[row][col] != "_"
      return true
    else
      return false
    end
  end

  def [](position)
    p position
    row, col = position
    @grid[row][col]
  end

  def []=(position, value)
    row, col = position
    @grid[row][col] = value
  end

  def print
    @grid.each do |row|
      p row
    end
  end

  def won?
    if @grid.flatten.none? { |value| value == "_" }
      puts "You win!"
      true
    else
    false
    end
  end

  def lost?
    if @num_remaining_guesses <= 0
      puts "You lose!"
      true
    else
      false
    end
  end

end

