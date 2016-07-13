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

    # \.
    ok = true
    c = field[1][1]
    for i in 0..2
      ok = false if field[i][i] != c
    end
    if ok then
      return c
    end

    # ./
    ok = true
    c = field[1][1]
    for i in 0..2
      ok = false if field[i][2-i] != c
    end
    if ok then
      return c
    end

    aiko = true
    for i in 0..2
      for j in 0..2
        if field[i][j] == 0
          aiko = false
          break
        end
      end
    end
    if aiko
      return -1
    end

    return 0
  end

  def self.count_reach(color, field)
    count = 0

    for i in 0..2
      n = 0
      for j in 0..2
        n += 1 if field[i][j] != color
      end
      count += 1 if n == 2
    end

    for j in 0..2
      n = 0
      for i in 0..2
        n += 1 if field[i][j] != color
      end
      count += 1 if n == 2
    end

    n = 0
    for i in 0..2
      n += 1 if field[i][i] != color
    end
    count += 1 if n == 2

    n = 0
    for i in 0..2
      n += 1 if field[i][2-i] != color
    end
    count += 1 if n == 2

    return n
  end

end
