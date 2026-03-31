class Word
  WORD_LIST_FILE_NAME='google-10000-english-no-swears.txt'

  def initialize
    @word=choose_random_word
  end

  def to_s
    @word
  end

  private
  # returns the list of words in WORD_LIST_FILE_NAME that are between 5 and 12 characters long
  def valid_word_list_array
    # each line is a new word but it needs to be chomped first to remove the '/n'
    # All words should already be lowercase, but ensure just in case
    all_words_in_file=File.readlines(WORD_LIST_FILE_NAME).map {|line| line.chomp.downcase}
    
    # return only words between 5 and 12 characters in length
    all_words_in_file.select {|word| word.length>=5 && word.length<=12}
  end

  # chooses a random word from results of valid_word_list_array method
  def choose_random_word()
    valid_word_list_array.sample
  end

end