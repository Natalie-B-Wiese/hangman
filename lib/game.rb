# frozen_string_literal: true

# for playing a full game of stickman
class Game
  require_relative 'word'
  require_relative 'stickman'

  def initialize
    @secret_word = Word.new
    @letters_guessed = []
    @num_incorrect = 0

    # debug purposes only. Delete
    puts "Secret word is: #{@secret_word}"
  end

  # plays an entire game of hangman
  def play_game
    until lost_game? || won_game?
      display_stats
      play_round
    end

    display_stats

    if lost_game?
      puts "You lost! The word was #{@secret_word}"
    else
      puts "You won! The word was #{@secret_word}"
    end
  end

  private

  # draws the stickman, shows incorrect guesses
  def display_stats
    Stickman.draw_stickman(@num_incorrect)
    puts "Incorrect guesses: #{@num_incorrect}/#{Stickman::INCORRECT_GUESSES}"

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

    @letters_guessed.push(letter)

    @num_incorrect += 1 unless @secret_word.letter_correct?(letter)
  end

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
