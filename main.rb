# frozen_string_literal: true

require_relative 'lib/start_setup'

setup = StartSetup.new

if setup.game.nil?
  puts 'Setup failed or was cancelled'
else
  setup.game.play_game
end
