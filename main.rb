require 'yaml'
require './game.rb'

players = YAML.load_file('./players.yml')

for player in players do
  next if player == 'human'
  require "./players/#{player["name"]}.rb"
end

# choose two-players
left = Module.const_get(players[0]["class"])
right = Module.const_get(players[1]["class"])

puts "Left: #{left}\nRight: #{right}"

# game init & run
count = 0
game = Game.new(left, right)
cond = 0
while cond == 0 do
  count += 1
  puts "Turn: #{count}"
  game.display
  cond = game.turn
end
game.display
puts "#{cond == 1 ? "Left" : "Right"} won!"
