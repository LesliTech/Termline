# Installation

Termline provides formatted terminal output for Ruby applications, scripts, Rake tasks, and command-line tools. It has no runtime gem dependencies and does not require Rails.

## Requirements

Termline supports Ruby 2.7.2 or newer.

Add it to the current bundle:

```shell
bundle add termline
```

Require the gem when Bundler does not load it automatically:

```ruby
require "termline"
```

Verify the installation:

```ruby
Termline.success "Termline is ready"
```

## Output and terminal detection

The public helpers write to `$stdout` by default. Assign another IO-compatible object to `Termline.output` when output needs to be captured or redirected:

```ruby
require "stringio"

buffer = StringIO.new
Termline.output = buffer
Termline.ansi = false

Termline.success "Saved", time: false
buffer.string # => "✔ SUCCESS: Saved\n"
```

ANSI mode defaults to `:auto`. In automatic mode, styling is enabled only for an interactive output and is disabled when `NO_COLOR` is present or `TERM=dumb`. Set `Termline.ansi` to `true` or `false` when deterministic output is required.

Terminal width is detected from the configured output, `COLUMNS`, or the system console and falls back to 80 columns. Override or reset it with:

```ruby
Termline.width = 100
Termline.width = nil # Resume automatic detection
```

Begin with [Messages](/gems/termline/messages), then use [Lists](/gems/termline/lists), [Tables](/gems/termline/tables), [Text components](/gems/termline/text), and [Separators and spacing](/gems/termline/separator) as needed.
