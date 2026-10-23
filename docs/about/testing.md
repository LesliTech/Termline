# Testing

Termline uses Minitest with LesliTesting's shared reporter and coverage configuration. Install the development dependencies and run the complete suite from the repository root:

```shell
bundle install
bundle exec rake
```

Run one test file while developing a focused change:

```shell
bundle exec ruby -Itest test/test_table.rb
```

## Coverage

Coverage is optional during local development:

```shell
COVERAGE=true bundle exec rake
```

The suite requires at least 90% line coverage. Reports are generated in `coverage/`, which is ignored by Git. Suppress the per-test result lines when a compact report is preferable:

```shell
QUIET=true COVERAGE=true bundle exec rake
```

LesliTesting uses Termline to render its reporter. For that reason, `test/test_helper.rb` starts coverage before registering the reporter; preserve this load order so Termline's source files remain measurable.

## Continuous integration

The GitHub Actions workflow runs the suite on Ruby 3.3.5 through the shared
`lesli-ci-gem.yaml` workflow from LesliActions and enforces the configured
coverage threshold.
