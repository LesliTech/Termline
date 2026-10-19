## Separators and Spacing

Termline includes simple helpers for adding blank lines and visual separators in terminal output.

In most cases, you should use the public shortcuts:

```ruby
Termline.br(count = 1)
Termline.line(count = 8)
```


## Blank Lines

Use `br` to print one or more blank lines:

```ruby
Termline.br
```

This prints a single line break.

You can also pass a custom count:

```ruby
Termline.br(3)
```

This prints three line breaks.


## Separator Lines

Use `line` to print a repeated visual separator:

```ruby
Termline.line
```

Example output:

```text
-·-     -·-     -·-     -·-     -·-     -·-     -·-     -·-
```

You can also pass a custom count:

```ruby
Termline.line(3)
```

Example output:

```text
-·-     -·-     -·-
```


## Method Signatures

```ruby
Termline.br(count = 1)
Termline.line(count = 8)
```

### Parameters

#### `count`
For `br`, the number of newline characters to generate. For `line`, the number of times the separator pattern is repeated.

Default values:

```ruby
Termline.br(1)
Termline.line(8)
```


## Behavior

These helpers:

- write to the configured `Termline.output`, which defaults to `$stdout`
- are useful for formatting CLI output
- provide simple visual spacing between sections
- make terminal output easier to scan

Internally, these methods delegate to the separator builder, but the recommended public API is to use `Termline.br` and `Termline.line`.


## Advanced Usage

For most cases, the public shortcuts are the recommended API.

If you need lower-level control or want to generate a custom spacing string, use `Termline::Space.builder`. The builder returns a string; it does not print it:

```ruby
Termline::Space.builder("\n", 3)
Termline::Space.builder("-·-     ", 4)
```

Examples:

```ruby
puts Termline::Space.builder("\n", 2)
puts Termline::Space.builder("-·-     ", 5)
```

Use this only when you need direct access to the internal separator builder. For normal usage, prefer:

```ruby
Termline.br(2)
Termline.line(5)
```


## Example with Structured Output

```ruby
Termline.info "Starting deployment"
Termline.line
Termline.success "Dependencies installed"
Termline.success "Database migrated"
Termline.br
Termline.info "Deployment completed"
```
