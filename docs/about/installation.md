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

The public helpers write to `$stdout` by default. Assign another IO-compatible object to `Termline.output` when output needs to be captured or redirected. Begin with [Messages](/gems/termline/messages), then use [Lists](/gems/termline/lists), [Tables](/gems/termline/tables), [Text components](/gems/termline/text), and [Separators and spacing](/gems/termline/separator) as needed.
