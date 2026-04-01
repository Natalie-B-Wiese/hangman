# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/save_load'

game = Game.new

game.play_game

# save_data = SaveLoad.load_serialized_game_data('savedata1.txt')

# if save_data
# game.unserialize(save_data)

# game.play_game

# end
