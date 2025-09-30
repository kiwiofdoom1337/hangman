require 'json'
require_relative "grabword"
require "pry"
class Guess
  attr_accessor :secret_word, :random_word, :secret_progress, :load_info
  def initialize
    @secret_word = []
    @secret_progress = []
    @player_guess = []
    @random_word = Grabword.new
    @load_info = {}
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

  def form_word
    guess.secret_word.join(" ")
  end

  def form_progress
    guess.secret_progress.join(" ")
  end

  def save_game
    save_data = {:secret_word => @secret_word, :secret_progress => @secret_progress}
    data_json = save_data.to_json
    save_file = File.open('save_data.json', 'w')
    save_file.puts data_json
    save_file.close
  end

  def load_game
    load_file = File.open('save_data.json', 'r')
    load_data = load_file.gets
    @load_info = JSON.parse(load_data)
    load_file.close
    @secret_word = @load_info[:secret_word]
    @secret_progress = @load_info[:secret_progress]
  end
end