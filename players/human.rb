class Human

    def initialize(verbose=false)
        puts "human: type a command to put a cell from STDIN. The command is such like a0 or c2)"
    end

    def reset
    end

    def run(color, field)
        while true
            print "? > "
            s = STDIN.gets
            j = "abc".index(s[0])
            i = "012".index(s[1])
            if i != nil and j != nil
                break
            end
            puts "illegal command (command is like `a0`)"
        end
        return [i, j]
    end
end
