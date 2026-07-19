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

Termline is a lightweight Ruby library for producing structured, readable terminal output.

It provides semantic messages, colors, icons, metadata, lists, tables, and separators through a small public API used throughout the Lesli ecosystem.

<br />

## Features

- Semantic info, success, warning, and danger messages
- Colored output with icons and timestamps
- Structured key-value metadata
- Lists and tabular output
- Reusable line and spacing helpers
- No application framework required

<br />

## Installation

Add Termline to the application:

```shell
bundle add termline
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

Attach structured metadata using keyword arguments:

```ruby
Termline.success "Compiled application.tailwind.css", size: "1.4 KB"
Termline.info "Connected", adapter: "postgres", duration: "12ms"
```

### Lists and tables

```ruby
Termline.list("Rails", "Lesli", "Tailwind")

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

<br />

## Documentation

- [Lesli website](https://www.lesli.dev/)
- [Documentation](https://www.lesli.dev/gems/termline/)
- [Release notes](https://github.com/LesliTech/Termline/releases)
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
