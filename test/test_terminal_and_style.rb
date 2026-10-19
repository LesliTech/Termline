# frozen_string_literal: true

require "test_helper"

class TestTerminalAndStyle < TermlineTestCase
    def test_terminal_prefers_the_configured_output_width
        Termline.output = SizedBuffer.new(132)
        Termline.width = nil

        assert_equal 132, Termline.width
    end

    def test_terminal_uses_columns_when_output_has_no_size
        previous = ENV["COLUMNS"]
        ENV["COLUMNS"] = "96"
        Termline.output = StringIO.new
        Termline.width = nil

        assert_equal 96, Termline.width
    ensure
        previous.nil? ? ENV.delete("COLUMNS") : ENV["COLUMNS"] = previous
    end

    def test_terminal_ignores_an_invalid_columns_value
        previous = ENV["COLUMNS"]
        ENV["COLUMNS"] = "wide"
        terminal_class = Class.new(Termline::Terminal) do
            private

            def width_from(_io)
                nil
            end
        end
        terminal = terminal_class.new(output: StringIO.new)

        assert_equal Termline::Terminal::DEFAULT_WIDTH, terminal.width
    ensure
        previous.nil? ? ENV.delete("COLUMNS") : ENV["COLUMNS"] = previous
    end

    def test_dumb_terminal_disables_automatic_ansi
        previous = ENV["TERM"]
        ENV["TERM"] = "dumb"
        Termline.output = TTYBuffer.new
        Termline.ansi = :auto

        refute Termline.terminal.ansi?
    ensure
        previous.nil? ? ENV.delete("TERM") : ENV["TERM"] = previous
    end

    def test_true_ansi_mode_overrides_non_tty_output
        Termline.output = StringIO.new
        Termline.ansi = true

        assert Termline.terminal.ansi?
    end

    def test_style_returns_plain_text_when_ansi_is_disabled
        Termline.ansi = false

        assert_equal "Ready", Termline::Style.colorize("Ready", :green, :black)
    end

    def test_background_bar_fills_the_configured_terminal_width
        Termline.width = 12

        rendered = Termline::Style.pretty("", :black, :red)
        visible = rendered.gsub(/\e\[[0-9;]*m/, "")

        assert_equal 12, visible.length
        assert_equal " " * 12, visible
    end

    def test_background_bar_does_not_truncate_a_long_message
        Termline.width = 4

        rendered = Termline::Style.pretty("message", :white, :red)
        visible = rendered.gsub(/\e\[[0-9;]*m/, "")

        assert_equal "message", visible
    end
end
