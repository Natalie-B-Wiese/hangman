# frozen_string_literal: true

# for playing a full game of stickman
class Game
  require_relative 'word'

  def initialize
    @secret_word = Word.new
    @letters_guessed = []

    # debug purposes only. Delete
    puts "Secret word is: #{@secret_word}"
  end

  def play_round
    letter = guess_letter
    @letters_guessed.push(letter)
  end

  private

  # prompts for a letter and returns lowercase user input
  def letter_prompt_answer
    puts 'Enter letter: '
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
