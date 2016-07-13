require './util.rb'

def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end

def reward(color, field)
  c = Util.end?(field)
  if c != 0  # when game is end
    if c == color
      return 100
    else
      return -100
    end
  end

  n = Util.count_reach(color, field)
  if n > 1
    return 10
  elsif n == 1
    return 5
  end

  return 0
end

def init_table(table, field)
  # initial if not contains
  return if table[field]
  table[field] = (1..3).map{|| [2]*3}
end

class Q

  def initialize
    # @table is Q-function
    # @table[field][i][j] = Q-value of (i, j) in the field
    @table = {}
    @alpha = 0.1
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
      fs[i][j] = color
      init_table(@table, fs)

      maxq = -1000
      for i2 in 0..2
        for j2 in 0..2
          maxq = [maxq, @table[fs][i2][j2]].max
        end
      end
      @table[field][i][j] = (1 - @alpha) * @table[field][i][j] + @alpha * (reward(color, fs) + maxq)

      fs[i][j] = 0
    end

    # choice
    z = 0.0
    zs = [0.0] * m
    for k in 0...m
      i, j = candidates[k]
      zs[k] = Math.exp(@table[field][i][j])
      z += zs[k]
    end

    p = rand
    for k in 0...m
      i, j = candidates[k]
      p = p - zs[k] / z
      return [i, j] if p < 0
    end

    return candidates[0]
  end

end
