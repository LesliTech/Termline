## Termline::List

Termline includes a simple list helper for printing collections as styled terminal bullets.

In most cases, you should use the public shortcut:

```ruby
Termline.list(*items, color: :default, icon: :debug)
```


## Basic Usage

```ruby
Termline.list(
  "PostgreSQL connected",
  "Redis connected",
  "Background jobs running"
)
```

Example output:

```text
  • PostgreSQL connected
  • Redis connected
  • Background jobs running
```


## Custom Icon and Color

```ruby
Termline.list(
  "Database connected",
  "Cache available",
  "Queue worker active",
  icon: :success,
  color: :green
)
```

Example output:

```text
  ✔ Database connected
  ✔ Cache available
  ✔ Queue worker active
```


## Using Warning Style

```ruby
Termline.list(
  "Disk usage above 80%",
  "Background retry queue growing",
  "High response time detected",
  icon: :warning,
  color: :yellow
)
```


## Using Star Style

```ruby
Termline.list(
  "Install dependencies",
  "Run migrations",
  "Start the server",
  icon: :star,
  color: :blue
)
```

Example output:

```text
  ★ Install dependencies
  ★ Run migrations
  ★ Start the server
```


## Method Signature

```ruby
Termline.list(*items, color: :default, icon: :debug)
```

### Parameters

| Parameter | Description |
| --- | --- |
| `items` | One or more strings or printable values. |
| `color` | Color key used to style the icon. It must exist in `Termline::Style::COLORS`. |
| `icon` | Icon key shown before each item. It must exist in `Termline::Style::ICONS`. |


## Available Icons

Termline currently includes these icons:

```ruby
:warning
:success
:debug
:error
:info
:star
:add
:remove
```


## Available Colors

The icon color can use any value from `Termline::Style::COLORS`:

```ruby
:skyblue
:default
:yellow
:white
:green
:black
:gray
:blue
:red
```


## Behavior

`Termline.list`:

- accepts multiple items as arguments
- prints one line per item
- renders the selected icon before each item
- applies color only to the icon
- prints the item text without additional formatting

Each item is rendered like this:

```text
  <icon> item text
```

Internally, this method delegates to `Termline::List.builder`, but the recommended public API is `Termline.list`.


## Advanced Usage

For most cases, `Termline.list` is the recommended API.

If you need lower-level control or want to integrate directly with the internal list builder, you can call:

```ruby
Termline::List.builder(items, color: :green, icon: :success)
```

Example:

```ruby
items = [
  "Database connected",
  "Cache available",
  "Queue worker active"
]

Termline::List.builder(items, color: :green, icon: :success)
```

Use this only when you need full control over how the list input is passed internally. For normal usage, prefer:

```ruby
Termline.list("Database connected", "Cache available", "Queue worker active", icon: :success, color: :green)
```


## Example with Status Checks

```ruby
Termline.info "System checks"

Termline.list(
  "Database connected",
  "Cache available",
  "Queue worker active",
  icon: :success,
  color: :green
)
```
