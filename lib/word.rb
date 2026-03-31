# frozen_string_literal: true

# Randomly picks a word from WORD_LIST_FILE_NAME that is the correct length
class Word
  WORD_LIST_FILE_NAME = 'google-10000-english-no-swears.txt'

  # min and max word length are inclusive
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12

  UNKNOWN_LETTER = '_'

  def initialize(word = nil)
    @word = word || choose_random_word
  end

  def to_s
    @word
  end

  # returns the word with placeholder (_) for unknown letters.
  def to_s_with_letters(letters_guessed = [])
    @word.chars.reduce('') do |total, letter|
      if letters_guessed.include?(letter)
        "#{total} #{letter}"
      else
        "#{total} #{UNKNOWN_LETTER}"
      end
    end
  end

  # returns true if the word contains the specified letter
  # Case insensitive search
  def letter_correct?(letter)
    @word.downcase.include?(letter.downcase)
  end

  # returns an array of letters within letters_guessed that are incorrect
  def incorrect_letters(letters_guessed)
    letters_guessed.reject do |letter|
      letter_correct?(letter)
    end
  end

  # returns true if user guessed all the letters in the word
  def word_guessed?(letters_guessed)
    (@word.chars - letters_guessed).empty?
  end

  private

  # returns the list of words in WORD_LIST_FILE_NAME that a valid length
  def valid_word_list_array
    # each line is a new word
    # Chomp the '\n' away and ensure the words are lowercase
    all_words_in_file = File.readlines(WORD_LIST_FILE_NAME).map { |line| line.chomp.downcase }
    all_words_in_file.select { |word| word.length >= MIN_WORD_LENGTH && word.length <= MAX_WORD_LENGTH }
  end

  # chooses a random word from results of valid_word_list_array method
  def choose_random_word
    valid_word_list_array.sample
  end
end
