require './util.rb'

def deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
end

def to_key(field)

    k1 = field.reduce(0){|ac, row|
        ac * 81 + row.reduce{|x,y| x*3 + y}
    }

    k2 = field.reduce(0){|ac, row|
        ac * 81 + row.reverse.reduce{|x,y| x*3 + y}
    }

    k3 = field.reverse.reduce(0){|ac, row|
        ac * 81 + row.reduce{|x,y| x*3 + y}
    }

    k4 = field.reverse.reduce(0){|ac, row|
        ac * 81 + row.reverse.reduce{|x,y| x*3 + y}
    }

    [k1, k2, k3, k4].min
end

def next_fields(color, field)
    ret = []
    for i in 0..2
        for j in 0..2
            next if field[i][j] != 0
            f = deep_copy(field)
            f[i][j] = color
            ret << [i, j, f]
        end
    end
    return ret
end

def reward(color, field)
    # i won in this field?
    if Util.end?(field) == color
        return 3
    end

    # i lost in any opponent hand
    for _, _, f in next_fields(3 - color, field)
        if Util.end?(f) == 3 - color
            return -3
        end
    end

    return 5
end

def init_table(table, key)
    # initial if not contains
    return if table[key]
    table[key] = (1..3).map{|| [0] * 3}
end

class Q

    def initialize(verbose=false)
        # @table is Q-function
        # @table[field][i][j] = Q-value of (i, j) in the field
        @table = {}
        @verbose = verbose
        reset
    end

    def reset
        @alpha = 0.2
        @gamma = 0.9
    end

    def run(color, field)

        @alpha *= 0.9
        key = to_key(field)
        init_table(@table, key)
        candidates = []

        # Q update
        for i, j, f in next_fields(color, field)
            candidates << [i, j]

            avgq = 0.0
            n = 0
            for _, _, f2 in next_fields(3 - color, f)
                key2 = to_key(f2)
                next if @table[key2] == nil
                for i3 in 0..2
                    for j3 in 0..2
                        avgq += @table[key2][i3][j3]
                        n += 1
                    end
                end
            end
            avgq /= n
            avgq = 0.0 if n == 0

            @table[key][i][j] *= (1 - @alpha)
            @table[key][i][j] += @alpha * reward(color, f)
            @table[key][i][j] += @alpha * @gamma * avgq
        end
        # p ["update", key, @table[key]]

        # choice
        z_sum = 0.0
        z = {}
        for i, j in candidates
            z[[i, j]] = [Math.exp(@table[key][i][j]), 1/candidates.size].max
            z_sum += z[[i, j]]
        end

        if @verbose
            puts "the goodness (probability)"
            for i, j in candidates
                q = z[[i, j]] / z_sum
                puts "[#{i}][#{j}] = #{q} (#{z[[i, j]]})"
            end
        end

        q = rand
        for i, j in candidates
            q = q - z[[i, j]] / z_sum
            return [i, j] if q < 0
        end

        return candidates[0]
    end

end
