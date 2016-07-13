# tic-tac-toe

## Usage

```bash
   ruby ./main.rb --silent --left random --right q --iteration 20000 >result.txt
   head result.txt
Left: RandomAI
Right: Q
Game #0:
= Right won after 8 turns!
Game #1:
= Left won after 9 turns!
Game #2:
= Right won after 6 turns!
Game #3:
= Left won after 9 turns!

   cat result.txt | grep ^= | awk '$0=$2' | tail -n 2000 | sort | uniq -c
 846 Draw
 376 Left
 778 Right
```

My `q` AI is about 2x stronger than `random` AI.

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
- [*] Q-learning

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

