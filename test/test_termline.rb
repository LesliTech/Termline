# frozen_string_literal: true

require "test_helper"
require "stringio"

class TestTermline < Minitest::Test
    class TTYBuffer < StringIO
        def tty?
            true
        end
    end

    def setup
        Termline.output = nil
        Termline.ansi = true
        Termline.width = 80
    end

    def teardown
        Termline.output = nil
        Termline.ansi = :auto
        Termline.width = nil
    end

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
end
