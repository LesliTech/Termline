## Termline::Details

Termline renders hashes and keyword pairs as aligned, readable details. The public helper writes to the configured output and returns the rendered content.

```ruby
Termline.details(data = nil, color: :blue, separator: ": ", icon: nil, icons: nil, **pairs)
```


## Basic Usage

Pass key-value pairs directly for the common case:

```ruby
Termline.details(
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

Labels are padded to the longest key, which keeps values easy to scan.


## Data Variants

Pass a hash when the data already exists as one object:

```ruby
deployment = {
  environment: "production",
  version: "1.4.0",
  workers: 4
}

Termline.details(deployment)
```

Additional keyword pairs are merged into the positional hash. When a key appears in both places, the additional pair wins:

```ruby
defaults = { environment: "development", workers: 2 }

Termline.details(
  defaults,
  environment: "production",
  release: "2026.10"
)
```

Values are converted to readable text. This works for strings, numbers, booleans, and `nil`:

```ruby
Termline.details(
  retries: nil,
  cached: true,
  duration: 12.5
)
```

```text
retries : nil
cached  : true
duration: 12.5
```


## Styling

Use `color` for labels and icons, and `separator` to change the boundary between keys and values:

```ruby
Termline.details(
  { host: "localhost", port: 3000 },
  color: :green,
  separator: " → "
)
```

```text
host → localhost
port → 3000
```


## Icons

Add the same icon to every row with `icon`:

```ruby
Termline.details(
  { environment: "production", workers: 4 },
  icon: :info
)
```

```text
ℹ environment: production
ℹ workers    : 4
```

Use `icons` to select an icon by key. String and symbol keys are both accepted:

```ruby
Termline.details(
  { status: "ready", workers: 4 },
  icon: :info,
  icons: { "status" => :success, workers: :star }
)
```

```text
✔ status : ready
★ workers: 4
```

The shared `icon` acts as the fallback for keys missing from `icons`. Without a fallback, Termline leaves an empty icon column so labels remain aligned. Icons use the same `color` as the labels and must exist in `Termline::Style::ICONS`.

Override only exceptional rows and use the shared icon everywhere else:

```ruby
Termline.details(
  { status: "ready", workers: 4, retries: 0 },
  icon: :info,
  icons: { status: :success, retries: :warning }
)
```

```text
✔ status : ready
ℹ workers: 4
⚠ retries: 0
```

Or omit the fallback to emphasize only selected values:

```ruby
Termline.details(
  { service: "api", region: "us-east-1", healthy: true },
  icons: { healthy: :success }
)
```

```text
  service: api
  region : us-east-1
✔ healthy: true
```

`icon` and `icons` are option names. To display either name as a key, pass it inside the positional data hash:

```ruby
Termline.details({ icon: "success", icons: 8 })
```


## Builder API

For composition without output, use the component builder directly:

```ruby
rendered = Termline::Details.builder(
  { status: "ready", workers: 4 },
  icons: { status: :success }
)
```

The component formats rows directly as strings and adds no runtime dependencies.
