## Termline::Table

Termline includes a simple table helper for printing structured data in the terminal.

In most cases, you should use the public shortcut:

```ruby
Termline.table(data, header: true)
```


## Basic Usage

```ruby
data = [
  { name: "Luis", role: "Admin", status: "Active" },
  { name: "Ana", role: "Developer", status: "Pending" },
  { name: "Marco", role: "Support", status: "Disabled" }
]

Termline.table(data)
```

Example output (column width varies with the terminal):

```text
| NAME                     | ROLE                     | STATUS
| - - - - - - - - - - - - -| - - - - - - - - - - - - -| - - - - - - - - - - - -
| Luis                     | Admin                    | Active
| Ana                      | Developer                | Pending
| Marco                    | Support                  | Disabled
```


## Using an Array of Hashes

The most common use case is an array of hashes:

```ruby
data = [
  { engine: "Lesli", tests: 93, coverage: "98.4%" },
  { engine: "LesliBell", tests: 41, coverage: "91.2%" },
  { engine: "LesliAdmin", tests: 67, coverage: "95.0%" }
]

Termline.table(data)
```

When the input is an array of hashes:

- the first row keys are used as table headers
- the header row is enabled by default
- each row's values are rendered in the insertion order of its hash
- rows should use the same keys in the same order



## Using an Array of Arrays

You can also pass an array of arrays:

```ruby
data = [
  ["Luis", "Admin", "Active"],
  ["Ana", "Developer", "Pending"],
  ["Marco", "Support", "Disabled"]
]

Termline.table(data)
```

When the input is an array of arrays:

- headers are automatically disabled
- each row is rendered as plain table data
- rows should contain the same number of values


## Header Option

Headers are enabled by default for hash-based data:

```ruby
Termline.table(data, header: true)
```

You can disable the header row manually:

```ruby
Termline.table(data, header: false)
```


## ActiveRecord Support

If the input is an `ActiveRecord::Relation`, it is automatically converted into an array of hashes using `serializable_hash`:

```ruby
users = User.limit(5)
Termline.table(users)
```

This makes it easy to print database records directly in the terminal.


## Method Signature

```ruby
Termline.table(data, header: true)
```

### Parameters

#### `data`
Supported input types:

- array of hashes
- array of arrays
- `ActiveRecord::Relation`

#### `header`
Controls whether the header row is displayed.

Default:

```ruby
true
```

For array-based rows, headers are always disabled.

## Behavior

`Termline.table` automatically:

- detects array-based rows
- detects hash-based rows
- converts ActiveRecord relations into printable hashes
- adjusts column width based on terminal width
- skips rendering if there is not enough space
- skips rendering on Windows platforms
- ignores empty collections

Values wider than their calculated column are not truncated or wrapped, so keep table content concise.

Internally, this method delegates to `Termline::Table.builder`, but the recommended public API is `Termline.table`.


## Advanced Usage

For most cases, `Termline.table` is the recommended API.

If you need lower-level control or want to integrate directly with the internal table builder, you can call:

```ruby
Termline::Table.builder(data, header: true)
```

Example:

```ruby
data = [
  { name: "Luis", role: "Admin", status: "Active" },
  { name: "Ana", role: "Developer", status: "Pending" }
]

puts Termline::Table.builder(data, header: true)
```

The builder returns a string without writing to the terminal. Use it only when you need to compose or inspect the rendered table. For normal usage, prefer:

```ruby
Termline.table(data, header: true)
```


## Example with Application Data

```ruby
Termline.info "Available users"

Termline.table([
  { id: 1, name: "Luis", email: "luis@example.com" },
  { id: 2, name: "Ana", email: "ana@example.com" }
])
```
