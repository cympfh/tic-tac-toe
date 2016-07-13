# tic-tac-toe

## players

プレイヤーに関する情報はすべて `players.yml` に書かれ、`main.rb` から利用されます.

The game players are human and AIs.
The list is on `players.yml` which is read from `main.rb`.

プライヤーの情報は `name` フィールドと `class` フィールドを持った要素のリストです. これは players/`name`.rb のなかに `class` クラスがあることを言っています.

The list is a array of elements each has `name` field and `class` field.
This says players/`name`.rb has `class` class.

For example,

```yaml
- name: random
  class: RandomAI
```

says that there is  `RandomAI` class for an game AI written in `random.rb`.

[*] Human (`players/human.rb`)
[*] RandomAI (`players/random.rb`)
[ ] Q-learning

### AI framework

A player (`class` in `name.rb`) must have following interface.

```
ai = RandomAI.new

ai.reset  # game reset

ai.run(color, state)  # return AI's action
```

where
`color` is the color of AI (`1` or `2`)
and the state is 2d-array for the game field.

## Expression of tic-tac-toe

The tic-tac-toe is 2 players game.
The 1st player called "left"
and the 2nd called "right".

A state is 2d-array sized with 3x3.
It expresses 3x3 cells.
The element of the 2d-array is `0`, `1` or `2`.
It means the colors of cells.

The initial state is repeat of `0`.

```
[[0, 0, 0],
 [0, 0, 0],
 [0, 0, 0]]
```

The left color a `0` cell with `1`.
The right color a `0` cell with `2`.


