class RandomAI

    def initialize(verbose=false)
    end

    def reset
    end

    def run(color, field)
        # randomly 0-cell choice
        candidates = []
        for i in 0..2
            for j in 0..2
                candidates << [i, j] if field[i][j] == 0
            end
        end
        candidates.shuffle!
        return candidates[0]
    end

end
