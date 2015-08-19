# rdoku
A very basic sudoku solver written in Ruby, just to spend some time while on vacation and to get to know Ruby a little better.

(Not so) loosely inspired by [this post](http://norvig.com/sudoku.html) by Peter Norvig, whose solution is *way* more elegant than mine; however, I came across the post after I already wrote most of the code, so likely my implementation could have been more concise and it will probably be in a future version.

My implementation is still incomplete as it does not contain the "searching" part of Peter Norvig's implementation; however, it's already able to solve the medium level puzzles at http://www.websudoku.com/.

## Usage

`ruby -I. run.rb <file>` , where `<file>` is a text file describing a sudoku grid like the following

```
X2XXXXX1X
4X6XX598X
5XXX9XXX3
2637XX8XX
XXXXXXXXX
XX8XX9734
3XXX2XXX8
X124XX3X5
X8XXXXX6X
```

With `X` characters representing the empty cells.

`run.rb` loads the sudoku grid from the input file, prints it in a nicely-formatted way and then prints the filled version, like this:

```
------------------------------------
| 8 | 2 | 9 | 3 | 4 | 6 | 5 | 1 | 7 |
------------------------------------
| 4 | 3 | 6 | 1 | 7 | 5 | 9 | 8 | 2 |
------------------------------------
| 5 | 7 | 1 | 8 | 9 | 2 | 6 | 4 | 3 |
------------------------------------
| 2 | 6 | 3 | 7 | 1 | 4 | 8 | 5 | 9 |
------------------------------------
| 9 | 4 | 7 | 5 | 3 | 8 | 1 | 2 | 6 |
------------------------------------
| 1 | 5 | 8 | 2 | 6 | 9 | 7 | 3 | 4 |
------------------------------------
| 3 | 9 | 5 | 6 | 2 | 1 | 4 | 7 | 8 |
------------------------------------
| 6 | 1 | 2 | 4 | 8 | 7 | 3 | 9 | 5 |
------------------------------------
| 7 | 8 | 4 | 9 | 5 | 3 | 2 | 6 | 1 |
------------------------------------
```

### Disclaimer
I don't claim to be a rubyist or to be any good at Ruby, so it's very likely that this code sucks from many different points of view: feel free to improve it by sending PRs.

