class Game
  attr_accessor :guess, :turns, :guess_letter

  def initialize
    @guess = Guess.new
    @turns = 10
    @guess_letter = ''
  end

  def welcome
    puts "Welcome to hangman!"
  end

  def generate_guess
    @guess.make_secret_word
    @guess.make_secret_progress
  end

  def display_progress
    @guess.form_progress
  end

  def display_word
    @guess.form_word
  end

  def ask_load
    puts "Would you like to load from a save file? [y/n]"
    response = gets.chomp.downcase
    if response == 'y'
      guess.load_game
      puts "Game loaded!"
    elsif response == 'n'
      puts "Starting new game..."
      generate_guess
    else
      puts "Invalid response. Starting new game.."
      generate_guess
    end
  end

  def ask_letter
    puts "Please guess a letter. Or type 'save' to save the game. #{@turns} turns left."
    letter = gets.chomp.downcase
    if letter == 'save'
      guess.save_game
      p "Game saved!"
    end
    while letter.length > 1 || ('a'..'z').to_a.none?(letter)
      puts "Please enter a valid letter."
      letter = gets.chomp.downcase
    end
    @guess_letter = letter
  end

  def check_match
    guess.secret_word.length.times do |i| 
      if guess.secret_word[i] == @guess_letter
        guess.secret_progress[i] = @guess_letter
      end
    end
    @turns -= 1
  end

  def game_finish
    if guess.secret_progress.none?("_")
      puts "Congratulations! You win!"
    else
      puts "You lose.\nThe word was '#{@guess.secret_word.join}'."
    end
  end


  def play
    welcome
    ask_load
    while @turns > 0 && guess.secret_progress.any?("_")
      display_progress
      ask_letter
      check_match
    end
   game_finish
  end
end