## Termline::List

Termline includes simple helpers for printing unordered and numbered collections.

In most cases, you should use the public shortcut:

```ruby
Termline.list(*items, color: :default, icon: :debug)
Termline.ordered_list(*items, color: :default, start: 1)
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


## Ordered Lists

Use `ordered_list` for steps or ranked items:

```ruby
Termline.ordered_list(
  "Install dependencies",
  "Configure the application",
  "Start the server"
)
```

Example output:

```text
  1. Install dependencies
  2. Configure the application
  3. Start the server
```

Change the first number with `start`:

```ruby
Termline.ordered_list("Retry request", "Report failure", start: 3, color: :yellow)
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
Termline.ordered_list(*items, color: :default, start: 1)
```

### Parameters

| Parameter | Description |
| --- | --- |
| `items` | One or more strings or printable values. |
| `color` | Color key used to style the icon. It must exist in `Termline::Style::COLORS`. |
| `icon` | Icon key shown before each item. It must exist in `Termline::Style::ICONS`. |
| `start` | First number used by `ordered_list`. Defaults to `1`. |


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

`Termline.ordered_list` follows the same behavior but uses incrementing numbers instead of icons.

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
Termline::List.builder(items, color: :blue, ordered: true, start: 1)
```

Example:

```ruby
items = [
  "Database connected",
  "Cache available",
  "Queue worker active"
]

puts Termline::List.builder(items, color: :green, icon: :success)
```

The builder returns a string without writing to the terminal. Use it only when you need to compose or inspect the rendered list. For normal usage, prefer:

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
