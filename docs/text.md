## Text Components

Termline includes lightweight section titles and aligned key-value blocks. Their public helpers write to the configured output and return the rendered content; their lower-level builders only return strings.


## Titles

```ruby
Termline.title "Deployment"
```

Example output in a 40-column terminal:

```text
── Deployment ─────────────────────────
```

The title adapts to the terminal width. Its color, fill character, and width can be changed:

```ruby
Termline.title "Database", color: :green
Termline.title "Summary", character: "=", width: 60
```


## Key-Value Blocks

```ruby
Termline.key_value(
  environment: "production",
  version: "1.4.0",
  workers: 4
)
```

Example output:

```text
environment: production
version    : 1.4.0
workers    : 4
```

Labels are padded to the longest key, which keeps values easy to scan. Customize the label color or separator when necessary:

```ruby
Termline.key_value({ host: "localhost", port: 3000 }, color: :green)
Termline.key_value({ status: "ready" }, separator: " = ")
```


## Builder API

The public helpers write to the configured output and return their rendered content. The lower-level builders only return strings:

```ruby
Termline::Text.title("Deployment", width: 40)
Termline::Text.key_value(environment: "production", version: "1.4.0")
```

These components do not introduce a markup parser or component tree; they remain small formatting helpers.
