module Util

    def self.end?(field)
        # return
        #   0  game goes on
        #  -1  draw
        #   1  left won
        #   2  right won

        for i in 0..2
            c = field[i][0]
            ok = true
            for j in 0..2
                ok = false if field[i][j] != c
            end
            if ok then
                return c
            end
        end

        for j in 0..2
            c = field[0][j]
            ok = true
            for i in 0..2
                ok = false if field[i][j] != c
            end
            if ok then
                return c
            end
        end

        if field[0][0] == field[1][1] and field[1][1] == field[2][2]
            return field[1][1]
        end

        if field[0][2] == field[1][1] and field[1][1] == field[2][0]
            return field[1][1]
        end

        if field.map{|row| row.count{|x| x == 0}}.inject(:+) == 0
            return -1
        end

        return 0
    end

end
