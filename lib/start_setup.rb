# frozen_string_literal: true

# prompts user to open game, start a new game, or quit
# It has a game variable that will be set based on user's input
# :game will be nil if start_setup failed or was cancelled
class StartSetup
  require_relative 'game'
  require_relative 'save_load'

  attr_reader :game

  def initialize
    # game is nil for if save could not open or if user selected option to quit
    @game = nil

    choice = open_new_or_quit

    if choice_open?(choice)
      data = try_open_data

      open_game_from_data(data) if data

    elsif choice_new?(choice)
      @game = Game.new
    end
  end

  private

  def open_game_from_data(data)
    @game = Game.new
    @game.unserialize(data)
  end

  def open_new_or_quit
    answer = open_new_or_quit_prompt_selection

    while answer.nil?
      puts 'Invalid choice!'
      print "\n"
      answer = open_new_or_quit_prompt_selection
    end

    answer
  end

  # displays two options to the user and returns user's response if it is valid
  # returns nil if invalid
  def open_new_or_quit_prompt_selection
    puts '0: Quit'
    puts '1: Open save game'
    puts '2: Play new game'
    print "\n"
    print 'Enter an option: '
    answer = gets.chomp
    valid = %w[0 1 2].include?(answer)
    return answer if valid

    nil
  end

  def choice_open?(choice)
    choice == '1'
  end

  def choice_new?(choice)
    choice == '2'
  end

  # returns data of file if valid
  # otherwise returns nil
  def try_open_data
    print "\n"

    # if there are files, then allow user to choose file to open
    return unless SaveLoad.print_all_save_files == true

    print "\n"
    puts 'Enter name of file to open: '
    filename = gets.chomp

    SaveLoad.load_serialized_game_data(filename)
  end
end
