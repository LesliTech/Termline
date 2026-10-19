## Termline::Msg

Termline includes a set of message helpers for printing structured terminal output with colors, icons, tags, timestamps, and key-value metadata.

```ruby
Termline.msg(*messages, bgcolor: :default, **data)
Termline.info(*messages, tag: "INFO:", icon: :info, time: true, bgcolor: :default, **data)
Termline.success(*messages, tag: "SUCCESS:", icon: :success, time: true, bgcolor: :default, **data)
Termline.warning(*messages, tag: "WARNING:", icon: :warning, time: true, bgcolor: :default, **data)
Termline.danger(*messages, tag: "DANGER:", icon: :error, time: true, bgcolor: :default, **data)
Termline.alert(*messages)
Termline.deprecation(*messages, time: true, **data)
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

Neutral and semantic message helpers accept multiple messages:

```ruby
Termline.info "Booting app", "Loading config", "Starting services"
```

Each message is printed on its own line.


## Key-Value Metadata

You can add structured metadata using keyword arguments:

```ruby
Termline.info "Connected", adapter: "postgres", duration: "12ms"
```

Example output:

```text
[12:45:02:123] ℹ INFO: Connected adapter=>postgres duration=>12ms
```

Metadata values are automatically formatted for display. Strings containing spaces are quoted.

`tag`, `icon`, and `time` are reserved options on semantic helpers. Use a different key, such as `duration`, when attaching timing metadata.



## Custom Tag and Icon

Each semantic helper has default values for `tag` and `icon`, but you can override them:

```ruby
Termline.info "User authenticated", tag: "AUTH:", icon: :star
```

Disable the timestamp with `time: false`:

```ruby
Termline.success "Cache warmed", time: false
```


## Alert Messages

Use `alert` for high-visibility output:

```ruby
Termline.alert "Critical error"
```

Each alert is printed once as white text on a red background. It does not use terminal blinking.


## Deprecation Messages

Use `deprecation` to identify APIs or behavior that will be removed:

```ruby
Termline.deprecation "The old command will be removed", replacement: "new-command"
```

Deprecations use the warning style with a `DEPRECATED:` tag.



## Method Signatures

```ruby
Termline.msg(*messages, bgcolor: :default, **data)
Termline.info(*messages, tag: "INFO:", icon: :info, time: true, bgcolor: :default, **data)
Termline.success(*messages, tag: "SUCCESS:", icon: :success, time: true, bgcolor: :default, **data)
Termline.warning(*messages, tag: "WARNING:", icon: :warning, time: true, bgcolor: :default, **data)
Termline.danger(*messages, tag: "DANGER:", icon: :error, time: true, bgcolor: :default, **data)
Termline.alert(*messages)
Termline.deprecation(*messages, time: true, **data)
```

### Parameters

| Parameter | Description |
| --- | --- |
| `messages` | One or more strings or printable values. |
| `tag` | Optional label shown before the message. |
| `icon` | Icon key shown before the tag. It must exist in `Termline::Style::ICONS`. |
| `time` | Whether to include the timestamp. Defaults to `true` on semantic helpers. |
| `bgcolor` | Optional background color from `Termline::Style::BG_COLORS`. |
| `data` | Additional keyword arguments rendered as key-value metadata. |


## Behavior

Public message helpers:

- accept one or more messages
- print one line per message
- prepend timestamps by default; semantic helpers accept `time: false`
- optionally render icons and tags
- support structured key-value metadata
- write to the configured `Termline.output`, which defaults to `$stdout`

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
  timestamp: Time.now.strftime("%H:%M:%S:%L"),
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
Termline.success "Connected", tag: "DB:", adapter: "postgres", duration: "12ms"
```


## Example with Application Output

```ruby
Termline.info "Request completed", method: "GET", path: "/users", status: 200
Termline.success "User created", id: 93
Termline.warning "Retrying request", attempt: 2
Termline.danger "Service unavailable", code: 503
```
