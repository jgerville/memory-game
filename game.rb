# require_relative "card.rb"
require_relative "board.rb"
require_relative "card_deck.rb"


class Game

  def initialize
    puts "Enter row/column size: "
    @size = gets.chomp.to_i
    @key_grid = Board.new(@size)
    @hidden_grid = Board.new(@size)
    @key_grid.populate
    puts "grid populated"

    until @hidden_grid.won? || @key_grid.lost?
      self.take_turns
    end
    puts "Game finished!"
  end


  # def play_game
    

  # end

  def take_turns
    puts "Enter coordinates where you want to check card value (ex: '0 1'): "
    first_position = gets.chomp.split(" ").map!(&:to_i)
    while first_position.any? { |num| num > @size - 1 }
      puts "Sorry, your coordinates were invalid."
      first_position = gets.chomp.split(" ").map!(&:to_i)
    end
    first_value = @key_grid[first_position]

    @hidden_grid[first_position] = first_value
    @hidden_grid.print

    # should flip over card at @board[position]
    puts "Enter coordinates where you want to check the second card value (ex: '0 1'): "
    second_position = gets.chomp.split(" ").map!(&:to_i)
    while (second_position.any? { |num| num > @size - 1 }) || (second_position == first_position)
      puts "Sorry, your coordinates were invalid."
      second_position = gets.chomp.split(" ").map!(&:to_i)
    end
    second_value = @key_grid[second_position]

    if first_value == second_value
      #flip over card at @board's second position
      @hidden_grid[second_position] = second_value
      @hidden_grid.print
    else
      @hidden_grid[second_position] = second_value
      @hidden_grid.print
      puts "Incorrect Guess :("
      puts "-------------------"
      @key_grid.num_remaining_guesses -= 1
      puts "You have #{@key_grid.num_remaining_guesses} remaining guesses!"
      @hidden_grid[first_position] = "_"
      @hidden_grid[second_position] = "_"
      @hidden_grid.print
    end
    
  end
  
end

# comment out if you don't want to play
Game.new