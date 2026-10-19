# Termline ToDo

## P3 · Advanced terminal components

P3 will extend Termline with richer terminal interfaces while preserving its current lightweight architecture: direct string builders, no markup parser, no component tree, and no runtime dependencies.

### Foundation

- [ ] Add a shared visible-width utility that ignores ANSI escape sequences.
- [ ] Handle Unicode and wide characters correctly when padding, aligning, and truncating content.
- [ ] Reuse the width utility in tables, titles, separators, and future components.
- [ ] Define consistent behavior for terminals that are too narrow to render a component.

### Components

- [ ] Add a `panel` component for bordered text, optional titles, padding, and semantic colors.
- [ ] Add a progress bar with configurable width, total, current value, label, and percentage.
- [ ] Add a spinner or status indicator for long-running tasks.
- [ ] Provide static builders for every component so output can be composed and tested without printing.
- [ ] Make dynamic components update in place only when the output is an interactive TTY.
- [ ] Provide readable, non-animated output when ANSI is disabled or output is redirected.

### API and configuration

- [ ] Define a small semantic theme API for message levels and component colors.
- [ ] Keep public helpers consistent with the existing `Termline.*` API.
- [ ] Support explicit width overrides without bypassing terminal-width safety.
- [ ] Validate component options and return actionable `ArgumentError` messages.

### Quality and documentation

- [ ] Add tests for ANSI and plain-text rendering.
- [ ] Add tests for narrow terminals, redirected output, Unicode content, and interrupted animations.
- [ ] Add examples to `test/demo_termline.rb`.
- [ ] Document every new public helper and its builder API.
- [ ] Update the README screenshot after the P3 components are stable.
- [ ] Confirm that the final gem still has no runtime dependencies.

### Definition of done

- [ ] All builders return strings without writing directly to the terminal.
- [ ] Dynamic output degrades cleanly outside a TTY.
- [ ] Existing P0–P2 APIs remain backward compatible.
- [ ] The complete test suite passes on every supported Ruby version.
- [ ] README, focused guides, demo, and packaged gem reflect the final P3 API.

### Out of scope

- HTML- or Tailwind-style markup parsing.
- A virtual component tree or terminal DOM.
- Full-screen terminal application management.
- Required runtime dependencies.
