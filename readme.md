<div align="center">
    <h1 align="center">
        <img width="100" alt="Termline" src="./docs/images/termline-logo.svg" />
    </h1>
    <h3 align="center">Human-friendly terminal output for Ruby applications.</h3>
</div>

<br />

<div align="center">
    <a target="_blank" href="https://github.com/LesliTech/Termline/actions/workflows/master.yml">
        <img alt="Termline test status" src="https://img.shields.io/github/actions/workflow/status/LesliTech/Termline/master.yml?branch=main&style=for-the-badge&logo=github&label=tests">
    </a>
    <a target="_blank" href="https://rubygems.org/gems/termline">
        <img alt="Gem Version" src="https://img.shields.io/gem/v/termline?style=for-the-badge&logo=ruby">
    </a>
    <a target="_blank" href="https://codecov.io/github/LesliTech/Termline">
        <img alt="Codecov" src="https://img.shields.io/codecov/c/github/LesliTech/Termline?style=for-the-badge&logo=codecov">
    </a>
    <a target="_blank" href="https://sonarcloud.io/project/overview?id=LesliTech_Termline">
        <img alt="Sonar Quality Gate" src="https://img.shields.io/sonar/quality_gate/LesliTech_Termline?server=https%3A%2F%2Fsonarcloud.io&style=for-the-badge&logo=sonarqubecloud&label=Quality">
    </a>
</div>

<br />

<div align="center">
    <img
        style="width:100%;max-width:800px;border-radius:6px;"
        alt="Termline formatted terminal output"
        src="./docs/images/screenshot.png" />
</div>

<br />

---

<br />

## Introduction

Termline provides human-friendly terminal output for applications and development tools built with the [Lesli Framework](https://github.com/LesliTech/Lesli).

It exposes a small Ruby API for semantic messages, colors, icons, structured metadata, lists, tables, and separators. Termline has no application-framework dependency, so it can also be used by standalone Ruby applications, scripts, Rake tasks, and command-line tools.

<br />

## Why Termline?

Termline provides:

- Consistent terminal output across the Lesli ecosystem
- Semantic info, success, warning, and danger messages
- Colored icons, labels, and timestamps
- Structured key-value metadata
- Styled lists and tabular output
- Reusable spacing and separator helpers
- A lightweight implementation with no runtime dependencies

<br />

## Quick Start

### Requirements

- Ruby 2.7.2 or newer

Termline is framework-independent and does not require Rails.

### Installation

Add Termline to the application:

```shell
bundle add termline
```

Require the gem when Bundler does not load it automatically:

```ruby
require "termline"
```

<br />

## Usage

### Messages

```ruby
require "termline"

Termline.msg "Hello world"
Termline.info "Server started"
Termline.success "All tests passed"
Termline.warning "Low disk space"
Termline.danger "Something failed"
```

Every semantic helper accepts multiple messages and prints each one on its own line:

```ruby
Termline.info "Loading configuration", "Connecting to database"
```

Attach structured metadata with keyword arguments:

```ruby
Termline.success "Compiled application.tailwind.css", size: "1.4 KB"
Termline.info "Connected", adapter: "postgres", duration: "12ms"
```

Override the default tag, icon, or timestamp when the output needs a different presentation:

```ruby
Termline.info "User authenticated", tag: "AUTH:", icon: :star
Termline.success "Cache warmed", time: false
```

### Lists and tables

```ruby
Termline.list("Rails", "Lesli", "Tailwind")
Termline.list("Database", "Cache", icon: :success, color: :green)

Termline.table([
  { name: "Luis", role: "Admin", status: "Active" },
  { name: "Ana", role: "Developer", status: "Pending" }
])
```

### Spacing and separators

```ruby
Termline.br
Termline.br(2)
Termline.line
```

### Public API

| Helper | Purpose |
| --- | --- |
| `Termline.m` | Print one or more unformatted values |
| `Termline.msg` | Print neutral messages with optional metadata |
| `Termline.info` | Print informational messages |
| `Termline.success` | Print successful outcomes |
| `Termline.warning` | Print warnings |
| `Termline.danger` | Print errors or failed outcomes |
| `Termline.alert` | Print a high-visibility blinking alert |
| `Termline.list` | Print a styled list |
| `Termline.table` | Print arrays, hashes, or Active Record relations as a table |
| `Termline.br` | Print blank lines |
| `Termline.line` | Print a visual separator |

Message, list, table, and spacing helpers print directly to `STDOUT`. See the focused guides for all supported options and lower-level builders:

- [Installation](https://www.lesli.dev/gems/termline/about/installation)
- [Messages](https://www.lesli.dev/gems/termline/messages)
- [Lists](https://www.lesli.dev/gems/termline/lists)
- [Tables](https://www.lesli.dev/gems/termline/tables)
- [Separators and spacing](https://www.lesli.dev/gems/termline/separator)

<br />

## Development

Clone the repository and install its dependencies:

```shell
git clone https://github.com/LesliTech/Termline.git
cd Termline
bundle install
```

To use local source from a Lesli development workspace, reference it from the host application's `Gemfile`:

```ruby
gem "termline", path: "gems/Termline"
```

### Tests

Run the default test task from the Termline directory:

```shell
bundle exec rake
```

Run the executable examples to preview the available output styles:

```shell
bundle exec ruby test/demo_termline.rb
```

<br />

## Documentation

- [Lesli website](https://www.lesli.dev/)
- [Termline documentation](https://www.lesli.dev/gems/termline/)
- [Releases and changelog](https://github.com/LesliTech/Termline/releases)
- [Issue tracker](https://github.com/LesliTech/Termline/issues)
- [Source code](https://github.com/LesliTech/Termline)

<br />

## Community

- [X: @LesliTech](https://x.com/LesliTech)
- [hello@lesli.tech](mailto:hello@lesli.tech)
- [https://www.lesli.tech](https://www.lesli.tech)

<br />

## License

Copyright (c) 2026, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

The complete license text is available in the [license file](./license.txt).

---

<br />
<br />

<div align="center">
    <img width="80" alt="Lesli icon" src="https://cdn.lesli.tech/lesli/brand/app-icon.svg" />
    <h3 align="center">The Open-Source SaaS Development Framework for Ruby on Rails.</h3>
</div>
