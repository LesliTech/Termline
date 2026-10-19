## Termline::Table

Termline renders compact tables that adapt to the available terminal width.

```ruby
Termline.table(data, header: true, align: :auto)
```


## Basic Usage

```ruby
data = [
  { name: "Luis", role: "Admin", requests: 125 },
  { name: "Ana", role: "Developer", requests: 42 }
]

Termline.table(data)
```

Example output:

```text
| NAME | ROLE      | REQUESTS |
|------|-----------|----------|
| Luis | Admin     |      125 |
| Ana  | Developer |       42 |
```

Hash keys form the header. Numeric columns are right-aligned automatically.


## Supported Data

### Array of hashes

```ruby
Termline.table([
  { engine: "Lesli", tests: 93, coverage: "98.4%" },
  { engine: "LesliBell", tests: 41, coverage: "91.2%" }
])
```

Rows may omit keys. Termline uses the union of the keys and leaves missing values blank.

### Single hash

```ruby
Termline.table({ name: "Termline", version: Termline::VERSION })
```

### Array of arrays

```ruby
Termline.table([
  ["Luis", "Admin", "Active"],
  ["Ana", "Developer", "Pending"]
])
```

Array rows do not generate a header. Short rows are padded with blank cells.

### Active Record relation

```ruby
Termline.table(User.limit(5))
```

Relations are converted with `serializable_hash` before rendering.


## Alignment

The default `:auto` alignment keeps text on the left and places numeric columns on the right.

Apply one alignment to every column:

```ruby
Termline.table(data, align: :center)
```

Or configure individual columns by key or zero-based index:

```ruby
Termline.table(
  data,
  align: { name: :left, role: :center, requests: :right }
)
```

Available values are `:auto`, `:left`, `:center`, and `:right`. An array can also provide one value per column.


## Width and Truncation

Termline uses `Termline.width`, which is detected from the output terminal and falls back to 80 columns. Long cells are truncated with an ellipsis instead of overflowing:

```text
| NAME     | DESCRIPTION        |
|----------|--------------------|
| Termline | Human-friendly te… |
```

Override the width when rendering into a known layout:

```ruby
Termline.width = 60
Termline.table(data)
```

If there is not enough room for at least one character per column, the builder returns an empty string.


## Header Option

Headers are enabled for hash rows by default:

```ruby
Termline.table(data, header: false)
```

With no header, Termline adds separators above and below the data.


## Builder API

`Termline.table` writes to the configured output and returns the rendered string. For composition without output, use the builder directly:

```ruby
rendered = Termline::Table.builder(data, header: true, align: :auto)
puts rendered
```

The implementation formats rows directly as strings and adds no runtime dependencies.
