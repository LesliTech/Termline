## Termline::Msg

Termline includes a set of message helpers for printing structured terminal output with colors, icons, tags, timestamps, and key-value metadata.

```ruby
Termline.msg(*messages, **data)
Termline.info(*messages, tag: 'INFO:', icon: :info, **data)
Termline.success(*messages, tag: 'SUCCESS:', icon: :success, **data)
Termline.warning(*messages, tag: 'WARNING:', icon: :warning, **data)
Termline.danger(*messages, tag: 'DANGER:', icon: :error, **data)
Termline.alert(*messages)
```


## Basic Usage

```ruby
Termline.msg "Hello world"
Termline.info "Server started"
Termline.success "All tests passed"
Termline.warning "Low disk space"
Termline.danger "Something failed"
```


## Message Levels

### Neutral Message

```ruby
Termline.msg "Plain message"
```

Use `msg` when you want a plain structured message without a predefined tag or icon.

### Info Message

```ruby
Termline.info "Server started"
```

### Success Message

```ruby
Termline.success "Deployment completed"
```

### Warning Message

```ruby
Termline.warning "Disk usage above 80%"
```

### Danger Message

```ruby
Termline.danger "Service unavailable"
```


## Multiple Messages

All public message methods accept multiple messages:

```ruby
Termline.info "Booting app", "Loading config", "Starting services"
```

Each message is printed on its own line.


## Key-Value Metadata

You can add structured metadata using keyword arguments:

```ruby
Termline.info "Connected", adapter: "postgres", time: "12ms"
```

Example output:

```text
[12:45:02:123] ℹ INFO: Connected adapter=>postgres time=>12ms
```

Metadata values are automatically formatted for display.



## Custom Tag and Icon

Each semantic helper has default values for `tag` and `icon`, but you can override them:

```ruby
Termline.info "User authenticated", tag: "AUTH:", icon: :star
```


## Alert Messages

Use `alert` for high-visibility output:

```ruby
Termline.alert "Critical error"
```

This uses blinking terminal output and a red highlighted version of the message.



## Method Signatures

```ruby
Termline.msg(*messages, **data)
Termline.info(*messages, tag: 'INFO:', icon: :info, **data)
Termline.success(*messages, tag: 'SUCCESS:', icon: :success, **data)
Termline.warning(*messages, tag: 'WARNING:', icon: :warning, **data)
Termline.danger(*messages, tag: 'DANGER:', icon: :error, **data)
Termline.alert(*messages)
```

### Parameters

|  |  |
|--- |--- | 
| **messages:** | One or more strings or printable values. | 
| **tag:** | An optional label shown before the message. | 
| **icon:** | The icon key used before the tag. The icon must exist in `Termline::Style::ICONS`. | 
| **data:** | Optional keyword arguments rendered as key-value metadata. | 


## Behavior

Public message helpers:

- accept one or more messages
- print one line per message
- prepend timestamps by default
- optionally render icons and tags
- support structured key-value metadata
- print directly to STDOUT

Internally, these methods delegate to `Termline::Msg.builder`, but the recommended public API is to use the `Termline` shortcuts.



## Advanced Usage

For most cases, the public shortcut methods are the recommended API.

If you need lower-level control or want to build a fully custom message, you can call:

```ruby
Termline::Msg.builder(
  "Connected",
  tag: "DB:",
  icon: :success,
  color: :green,
  timestamp: Time.now.strftime('%H:%M:%S:%L'),
  data: { adapter: "postgres", time: "12ms" }
)
```

Example:

```ruby
puts Termline::Msg.builder(
  "Connected",
  tag: "DB:",
  icon: :success,
  color: :green,
  data: { adapter: "postgres", time: "12ms" }
)
```

Use this only when you need direct access to the internal message builder. For normal usage, prefer:

```ruby
Termline.success "Connected", tag: "DB:", adapter: "postgres", time: "12ms"
```


## Example with Application Output

```ruby
Termline.info "Request completed", method: "GET", path: "/users", status: 200
Termline.success "User created", id: 93
Termline.warning "Retrying request", attempt: 2
Termline.danger "Service unavailable", code: 503
```
