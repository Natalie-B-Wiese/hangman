# frozen_string_literal: true

# saves and loads games from a file
class SaveLoad
  SAVE_FILE_NAME = 'savedata'
  EXT = '.txt'

  # saves a game into a file
  def self.save_serialized_game(serialized_game)
    filename = new_file_name

    f = File.new filename, 'w'
    f.print serialized_game
    f.close
    puts "Successfully saved game as #{filename}"
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
    filename = SAVE_FILE_NAME + game_id.to_s + EXT

    while File.exist? filename
      game_id += 1
      filename = SAVE_FILE_NAME + game_id.to_s + EXT
    end
    filename
  end
end
