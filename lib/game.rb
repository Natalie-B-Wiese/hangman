# frozen_string_literal: true

require_relative 'serializable'

# for playing a full game of stickman
class Game
  require_relative 'word'
  require_relative 'stickman'
  require_relative 'save_load'

  include Serializable
  attr_accessor :secret_word, :letters_guessed, :num_incorrect

  def initialize
    @secret_word = Word.new
    @letters_guessed = []
    @num_incorrect = 0
    @has_quit = false
  end

  # plays an entire game of hangman
  def play_game
    until lost_game? || won_game? || @has_quit
      display_stats
      play_round
    end

    # don't show display_stats when the game is quit
    display_stats if @has_quit == false

    if lost_game?
      puts "You lost! The word was #{@secret_word}"
    elsif won_game?
      puts "You won! The word was #{@secret_word}"
    end
  end

  # needs a custom unserialize method in order to deserialize secret_word as an object
  def unserialize(string)
    obj = @@serializer.parse(string)

    # deserialize the secret word as an object
    obj['@secret_word'] = Word.new(obj['@secret_word'])

    obj.each_key do |key|
      instance_variable_set(key, obj[key])
    end
  end

  private

  # draws the stickman, shows incorrect guesses
  def display_stats
    Stickman.draw_stickman(@num_incorrect)
    puts "Incorrect guesses: #{@num_incorrect}/#{Stickman::INCORRECT_GUESSES}"

    incorrect_letters = @secret_word.incorrect_letters(@letters_guessed)
    puts "Incorrect letters: #{incorrect_letters.join(' ')}" if incorrect_letters.empty? == false

    # show the progress on the word
    puts @secret_word.to_s_with_letters(@letters_guessed)
  end

  def lost_game?
    @num_incorrect >= Stickman::INCORRECT_GUESSES
  end

  def won_game?
    @secret_word.word_guessed?(@letters_guessed)
  end

  def play_round
    # get the user's guess
    letter = guess_letter

    if letter == '1'
      save_and_quit
    elsif letter == '0'
      quit
    else
      @letters_guessed.push(letter)
      @num_incorrect += 1 unless @secret_word.letter_correct?(letter)
    end
  end

  def save_and_quit
    SaveLoad.save_serialized_game(serialize)
    quit
  end

  def quit
    puts 'Quitting game'
    @has_quit = true
  end

  # prompts for a letter and returns lowercase user input
  def letter_prompt_answer
    puts 'Guess a letter (or input 1 to save and quit, or input 0 to quit without saving): '
    gets.chomp.downcase
  end

  # returns true if the letter is valid
  # if invalid, it prints an error message and returns false
  def letter_valid?(letter)
    if letter.length != 1
      puts 'Invalid length!'
      false
    elsif @letters_guessed.include?(letter)
      puts 'Letter already guessed!'
      false
    else
      true
    end
  end

  # prompts user to enter a letter and returns the valid letter
  def guess_letter
    valid = false

    until valid
      answer = letter_prompt_answer
      valid = letter_valid?(answer)
    end

    answer
  end
end
