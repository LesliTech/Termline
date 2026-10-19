# frozen_string_literal: true

require "test_helper"

class TestTermline < Minitest::Test
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
end
