require './util.rb'

def deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
end

def reward(color, fs, verbose)

    field = deep_copy(fs)

    # i won in this field?
    if Util.end?(field) == color
        if verbose
            puts "I winning"
        end
        return 100
    end

    # i lost in any next field?
    for i in 0..2
        for j in 0..2
            next if field[i][j] != 0
            field[i][j] = 3 - color
            if Util.end?(field) == 3 - color
                if verbose
                    puts "I lost by #{i},#{j}"
                end
                return -100
            end
            field[i][j] = 0
        end
    end

    return 0
end

def init_table(table, field)
    # initial if not contains
    return if table[field]
    table[field] = (1..3).map{|| [2]*3}
end

class Q

    def initialize(verbose=false)
        # @table is Q-function
        # @table[field][i][j] = Q-value of (i, j) in the field
        @table = {}
        @alpha = 0.1
        @verbose = verbose
    end

    def reset
    end

    def run(color, field)
        candidates = []  # 0-cells
        for i in 0..2
            for j in 0..2
                candidates << [i, j] if field[i][j] == 0
            end
        end
        m = candidates.size

        # Q update
        init_table(@table, field)
        fs = deep_copy(field)
        for i, j in candidates
            if @verbose
                puts "I thinking about #{i},#{j}"
            end
            fs[i][j] = color
            init_table(@table, fs)

            maxq = -1000
            for i2 in 0..2
                for j2 in 0..2
                    maxq = [maxq, @table[fs][i2][j2]].max
                end
            end
            r = reward(color, fs, @verbose)
            @table[field][i][j] = (1 - @alpha) * @table[field][i][j] + @alpha * (r + maxq)

            fs[i][j] = 0
        end

        # choice
        z = 0.0
        zs = [0.0] * m
        for k in 0...m
            i, j = candidates[k]
            zs[k] = [Math.exp(@table[field][i][j]), 0.01].max
            z += zs[k]
        end

        for k in 0...m
            i, j = candidates[k]
            if @verbose
                puts "the goodness (probability) for #{i},#{j} is #{zs[k]/z}"
            end
        end

        q = rand
        for k in 0...m
            i, j = candidates[k]
            q = q - zs[k] / z
            return [i, j] if q < 0
        end

        return candidates[0]
    end

end
