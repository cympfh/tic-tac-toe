module Util

  def self.end?(field)
    # ->
    for i in 0..2 do
      c = field[i][0]
      ok = true
      for j in 0..2 do
        ok = false if field[i][j] != c
      end
      if ok then
        return c
      end
    end

    # v
    for j in 0..2 do
      c = field[0][j]
      ok = true
      for i in 0..2 do
        ok = false if field[i][j] != c
      end
      if ok then
        return c
      end
    end

    # \.
    ok = true
    c = field[1][1]
    for i in 0..2 do
      ok = false if field[i][i] != c
    end
    if ok then
      return c
    end

    # ./
    ok = true
    c = field[1][1]
    for i in 0..2 do
      ok = false if field[i][2-i] != c
    end
    if ok then
      return c
    end

    return 0
  end

end
