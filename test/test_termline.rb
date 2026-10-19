# frozen_string_literal: true

require "test_helper"

class TestTermline < TermlineTestCase

    def test_that_it_has_a_version_number
        refute_nil ::Termline::VERSION
    end

    def test_info_prints_the_rendered_message
        output, = capture_io do
            Termline.info("Testing info", time: false)
        end

        assert_equal "\e[34;49mℹ\e[0m \e[34;49mINFO:\e[0m Testing info\n", output
    end

    def test_alert_prints_one_high_visibility_line
        output, = capture_io do
            Termline.alert("Danger")
        end

        assert_equal "\e[1;37;41m Danger \e[0m\n", output
    end

    def test_message_builder_applies_a_background_color
        message = Termline::Msg.builder("Hello", bgcolor: :red, time: false)

        assert_equal "\e[39;41mHello\e[0m", message
    end

    def test_deprecation_prints_a_semantic_warning
        output, = capture_io do
            Termline.deprecation("Old API", time: false)
        end

        assert_includes output, "DEPRECATED:"
        assert_includes output, "Old API"
        assert_equal 1, output.lines.size
    end

    def test_invalid_color_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Style.colorize("Hello", :missing)
        end

        assert_includes error.message, "Unknown color"
    end

    def test_invalid_background_color_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Style.colorize("Hello", :default, :missing)
        end

        assert_includes error.message, "Unknown background color"
    end

    def test_invalid_icon_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Style.icon(:missing)
        end

        assert_includes error.message, "Unknown icon"
    end

    def test_color_prints_a_background_line
        output, = capture_io do
            Termline.color(:red)
        end

        assert_match(/\A\e\[30;41m +\e\[0m\n\z/, output)
    end

    def test_output_can_be_configured
        buffer = StringIO.new
        Termline.output = buffer
        Termline.ansi = false

        rendered = Termline.success("Saved", time: false)

        assert_equal "✔ SUCCESS: Saved", rendered
        assert_equal "✔ SUCCESS: Saved\n", buffer.string
    end

    def test_auto_mode_disables_ansi_for_non_tty_output
        buffer = StringIO.new
        Termline.output = buffer
        Termline.ansi = :auto

        Termline.info("Plain", time: false)

        assert_equal "ℹ INFO: Plain\n", buffer.string
        refute_includes buffer.string, "\e["
    end

    def test_color_bar_is_omitted_when_ansi_is_disabled
        buffer = StringIO.new
        Termline.output = buffer
        Termline.ansi = false

        rendered = Termline.color(:red)

        assert_equal "", rendered
        assert_empty buffer.string
    end

    def test_no_color_disables_ansi_for_tty_output
        previous_value = ENV["NO_COLOR"]
        had_no_color = ENV.key?("NO_COLOR")
        ENV["NO_COLOR"] = "1"

        buffer = TTYBuffer.new
        Termline.output = buffer
        Termline.ansi = :auto
        Termline.warning("Plain", time: false)

        assert_equal "⚠ WARNING: Plain\n", buffer.string
    ensure
        had_no_color ? ENV["NO_COLOR"] = previous_value : ENV.delete("NO_COLOR")
    end

    def test_list_builder_returns_text_without_printing
        output, = capture_io do
            @list = Termline::List.builder(["one", "two"], color: :green, icon: :success)
        end

        assert_empty output
        assert_equal "  \e[32;49m✔\e[0m one\n  \e[32;49m✔\e[0m two", @list
    end

    def test_table_builder_returns_text_without_printing
        output, = capture_io do
            @table = Termline::Table.builder([{ name: "Ada", status: "Ready" }])
        end

        assert_empty output
        assert_includes @table, "NAME"
        assert_includes @table, "Ada"
    end

    def test_empty_table_does_not_write_a_blank_line
        buffer = StringIO.new
        Termline.output = buffer

        rendered = Termline.table([])

        assert_equal "", rendered
        assert_empty buffer.string
    end

    def test_terminal_width_can_be_overridden
        Termline.width = 42

        assert_equal 42, Termline.width
    end

    def test_invalid_terminal_configuration_is_rejected
        assert_raises(ArgumentError) { Termline.output = Object.new }
        assert_raises(ArgumentError) { Termline.ansi = :sometimes }
        assert_raises(ArgumentError) { Termline.width = 0 }
    end

    def test_message_timestamps_can_be_configured_globally
        buffer = StringIO.new
        Termline.output = buffer
        Termline.ansi = false

        configured = Termline.configure do |config|
            config.timestamps = false
            config.timestamp_format = "%H:%M:%S"
        end

        Termline.info("Quiet timestamp")

        assert_same Termline, configured
        assert_equal "ℹ INFO: Quiet timestamp\n", buffer.string
        assert_equal "%H:%M:%S", Termline.timestamp_format
    end

    def test_explicit_message_time_overrides_global_configuration
        Termline.timestamps = false

        message = Termline::Msg.builder("Visible", timestamp: "10:20", time: true)

        assert_equal "[10:20] Visible", message
    end

    def test_invalid_message_configuration_is_rejected
        assert_raises(ArgumentError) { Termline.timestamps = :sometimes }
        assert_raises(ArgumentError) { Termline.timestamp_format = "" }
        assert_raises(ArgumentError) { Termline::Msg.builder("Hello", time: :sometimes) }
    end

    def test_metadata_uses_readable_key_value_notation
        Termline.ansi = false

        message = Termline::Msg.builder(
            "Connected",
            time: false,
            data: { adapter: "postgres", duration: "12 ms" }
        )

        assert_equal 'Connected adapter=postgres duration="12 ms"', message
    end

    def test_ordered_list_supports_a_custom_start
        buffer = StringIO.new
        Termline.output = buffer
        Termline.ansi = false

        rendered = Termline.ordered_list("Install", "Run", start: 3, color: :green)

        assert_equal "  3. Install\n  4. Run", rendered
        assert_equal "  3. Install\n  4. Run\n", buffer.string
    end

    def test_table_truncates_content_to_terminal_width
        Termline.ansi = false
        Termline.width = 20

        table = Termline::Table.builder([
            { name: "Alexander Hamilton", count: 12 },
            { name: "Ada", count: 3 }
        ])

        assert_includes table, "Alexand…"
        assert table.lines.all? { |line| line.chomp.length <= 20 }
        assert_match(/\|\s+12 \|/, table)
    end

    def test_table_alignment_can_be_selected_by_column
        Termline.ansi = false
        Termline.width = 40

        table = Termline::Table.builder(
            [{ name: "Ada", score: 9 }],
            align: { name: :center, score: :left }
        )

        data_row = table.lines.last.chomp
        assert_match(/\| Ada\s* \| 9\s* \|/, data_row)
    end

    def test_adaptive_separator_uses_terminal_width
        buffer = StringIO.new
        Termline.output = buffer
        Termline.width = 12

        rendered = Termline.line

        assert_equal "─" * 12, rendered
        assert_equal "#{"─" * 12}\n", buffer.string
    end

    def test_legacy_separator_count_remains_supported
        Termline.ansi = false
        Termline.output = StringIO.new

        rendered = Termline.line(2)

        assert_equal "-·-     -·-     ", rendered
    end

    def test_adaptive_separator_rejects_empty_characters
        error = assert_raises(ArgumentError) { Termline::Space.line("", 20) }

        assert_includes error.message, "cannot be empty"
    end

    def test_title_fills_the_available_width
        Termline.ansi = false

        title = Termline::Text.title("Deploy", width: 20)

        assert_equal "── Deploy ──────────", title
        assert_equal 20, title.length
    end

end
