# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/save_load'

game = Game.new

save_data = SaveLoad.load_serialized_game_data('savedata1.txt')

if save_data
  game.unserialize(save_data)

  game.play_game

  # test of writing complete game to file
  SaveLoad.save_serialized_game(game.serialize)
end
