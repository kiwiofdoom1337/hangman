require 'json'
require_relative "grabword"
require "pry"
class Guess
  attr_accessor :secret_word, :random_word
  def initialize
    @secret_word = []
    @secret_progress = []
    @player_guess = []
    @random_word = Grabword.new
  end

  def secret_word
    word = @random_word.random_word(@random_word.words).strip.chars
    @secret_word = word
  end

  def secret_progress
    @secret_word.length.times do
      @secret_progress.push("_")
    end
    @secret_progress
  end

  def save_game
    save_data = {:secret_word => @secret_word, :secret_progress => @secret_progress}
    data_json = save_data.to_json
    save_file = File.open('save_data.json', 'w')
    save_file.puts data_json
  end
end

guess = Guess.new
p guess.secret_word.join(" ")
p guess.secret_progress.join(" ")
guess.save_game