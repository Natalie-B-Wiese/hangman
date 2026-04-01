# frozen_string_literal: true

# saves and loads games from a file
class SaveLoad
  require 'fileutils'

  SAVE_DIR = 'save_data'
  SAVE_FILE_NAME = 'game'
  EXT = '.txt'

  # saves a game into a file
  def self.save_serialized_game(serialized_game)
    filename = new_file_name

    f = File.new filename, 'w'
    f.print serialized_game
    f.close
    puts "Successfully saved game as #{file_name_without_path(filename)}"
  end

  def self.load_serialized_game_data(filename)
    if File.exist? filename
      puts 'Loading file'
      File.readlines(filename).join("\n")
    else
      puts 'File does not exist!'
    end
  end

  # gets the name of a new save file
  def self.new_file_name
    game_id = 1
    filename = full_file_name(game_id)

    while File.exist? filename
      game_id += 1
      filename = full_file_name(game_id)
    end
    filename
  end

  # creates the folder to save files in if it doesn't exist
  # Then returns the path to the file with the specified game_id
  def self.full_file_name(game_id)
    FileUtils.mkdir_p(SAVE_DIR) unless File.directory?(SAVE_DIR)
    filename = SAVE_FILE_NAME + game_id.to_s + EXT
    File.join(SAVE_DIR, filename)
  end

  def self.file_name_without_path(filename)
    # index 0 of File.split is always the full path while index 1 is always the name of the file
    File.split(filename)[1]
  end
end
