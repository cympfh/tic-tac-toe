require './util.rb'

class Game

    def initialize(left, right, verbose=false)
        @left = left.new(verbose)
        @right = right.new(verbose)
        reset
    end

    def reset
        @field = (1..3).map{|| [0]*3}
        @current = 1
        @left.reset
        @right.reset
    end

    def turn
        if @current == 1 then
            i, j = @left.run @current, @field
        else
            i, j = @right.run @current, @field
        end
        if @field[i][j] == 0
            @field[i][j] = @current
        end
        @current = 3 - @current  # flip
        return Util::end?(@field)
    end

    def display
        puts "  a b c"
        for i in 0..2 do
            puts "#{i} #{@field[i].map{|c| "-ox"[c]}.join(' ')}"
        end
        puts "---"
    end

end
