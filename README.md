# tic-tac-toe

## Usage

```bash
   ruby ./main.rb --silent --left random --right q --iteration 2000 >result.txt
```

The left (1st) player is `random` (players/random.rb),
and the right (2nd) player is `q` (players/q.rb).
`random` plays randomly.
`q` also plays randomly but learns good ways along a reward.

```bash
   head result.txt
Left: RandomAI
Right: Q
Game #0:
= Left won after 5 turns!
Game #1:
= Draw after 9 turns
Game #2:
= Left won after 9 turns!
Game #3:
= Left won after 7 turns!
```

In general,
tic-tac-toe is a game in which the left is priority to the right and
the game result must be draw if the 2 players are enough wise.

```bash
./main.rb --left random --right q -s -i 2000 | grep ^= | awk '$0=$2' | sort | uniq -c
737 Draw
374 Left
889 Right

./main.rb --left q --right random -s -i 2000 | grep ^= | awk '$0=$2' | sort | uniq -c
 191 Draw
1762 Left
  47 Right
```

To `random`, `q` is 2x stronger when it is right, and is 40x stronger when it is left.

## players

`cat players.yml`

```yaml
human: Human
random: RandomAI
q: Q
```

This says that 3 players are registered.
"human", "random" and "q" are the names of players.
And "Human", "RandomAI" and "Q" are the classes.
The class "Human" is denoted in "players/human.rb".
Please see `players/`.

says that there is  `RandomAI` class for an game AI written in `random.rb`.

- [x] Human (`players/human.rb`)
- [x] RandomAI (`players/random.rb`)
- [ ] Markov Decision Process
- [x] Q-learning

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

The left fills a `0` cell with color `1`.
The right fills a `0` cell with color `2`.

