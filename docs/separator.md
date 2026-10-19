## Separators and Spacing

Termline includes small helpers for blank lines and visual separators.

```ruby
Termline.br(count = 1)
Termline.line(character: "─", width: nil)
```


## Blank Lines

```ruby
Termline.br
Termline.br(3)
```

`br` prints one or more newline characters.


## Adaptive Separators

`line` fills the current terminal width by default:

```ruby
Termline.line
```

For a 20-column output, this renders:

```text
────────────────────
```

Choose another character or an explicit width:

```ruby
Termline.line(character: "=")
Termline.line(character: "·-", width: 40)
```

Multi-character patterns are repeated and cropped to the requested width.


## Compatibility

The previous positional count remains supported:

```ruby
Termline.line(3)
```

It renders the original `-·-     ` pattern three times. Prefer the adaptive keyword API for new code.


## Builder API

Builders return strings without writing them:

```ruby
Termline::Space.builder("\n", 2)
Termline::Space.line("─", 40)
```

Public helpers write to `Termline.output`, which defaults to `$stdout`.
