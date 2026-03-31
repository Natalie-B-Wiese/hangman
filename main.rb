# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new

(1..10).each do |round|
  puts "Round #{round}/10"
  game.play_round
end

puts 'Game over'
