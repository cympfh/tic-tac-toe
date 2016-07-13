require 'yaml'
require 'optparse'
require './game.rb'

args = {
  :iteration => 1,
  :left => 'random',
  :right => 'random',
}
OptionParser.new{|opts|
  opts.on("-s", "--silent", "game field never displayed"){|v|
    args[:silent] = v
  }
  opts.on("--iteration [INT]", "game times"){|n|
    args[:iteration] = n.to_i
  }
  opts.on("--left [NAME]", "The left player name"){|name|
    args[:left] = name
  }
  opts.on("--right [NAME]", "The right player name"){|name|
    args[:right] = name
  }
}.parse!

players = YAML.load_file('./players.yml')
for name, _ in players
  require "./players/#{name}.rb"
end

# choose two-players
left = Module.const_get(players[args[:left]])
right = Module.const_get(players[args[:right]])

puts "Left: #{left}\nRight: #{right}"

# game init & run
args[:iteration].times {|_|
  count = 0
  cond = 0
  game = Game.new(left, right)

  puts "Game ##{_}:"
  game.display if not args[:silent]
  while cond == 0
    count += 1
    cond = game.turn
    if not args[:silent]
      puts "Turn: #{count}"
      game.display
    end
  end

  if cond == -1
    puts "= Draw after #{count} turns"
  else
    puts "= #{cond == 1 ? "Left" : "Right"} won after #{count} turns!"
  end
}
