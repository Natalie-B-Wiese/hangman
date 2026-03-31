# frozen_string_literal: true

# Randomly picks a word from WORD_LIST_FILE_NAME that is the correct length
class Word
  WORD_LIST_FILE_NAME = 'google-10000-english-no-swears.txt'

  # min and max word length are inclusive
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12

  def initialize
    @word = choose_random_word
  end

  def to_s
    @word
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
