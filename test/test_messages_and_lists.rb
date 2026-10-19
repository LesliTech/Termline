# frozen_string_literal: true

require "test_helper"

class TestMessagesAndLists < TermlineTestCase
    def setup
        super
        Termline.ansi = false
        @output = StringIO.new
        Termline.output = @output
    end

    def test_plain_message_uses_the_global_timestamp_setting
        Termline.timestamps = false

        rendered = Termline.msg("Hello")

        assert_equal "Hello", rendered
        assert_equal "Hello\n", @output.string
    end

    def test_message_timestamp_format_is_applied_at_render_time
        Termline.timestamp_format = "year-%Y"

        rendered = Termline::Msg.builder("Hello")

        assert_match(/\A\[year-\d{4}\] Hello\z/, rendered)
    end

    def test_semantic_helpers_render_their_expected_levels
        Termline.timestamps = false

        assert_equal "ℹ INFO: Info", Termline.info("Info")
        assert_equal "✔ SUCCESS: Saved", Termline.success("Saved")
        assert_equal "⚠ WARNING: Careful", Termline.warning("Careful")
        assert_equal "✖ DANGER: Failed", Termline.danger("Failed")
    end

    def test_multiple_messages_are_written_one_per_line
        rendered = Termline.info("One", "Two", time: false)

        assert_equal "ℹ INFO: One\nℹ INFO: Two", rendered
        assert_equal "ℹ INFO: One\nℹ INFO: Two\n", @output.string
    end

    def test_metadata_formats_non_string_values
        rendered = Termline::Msg.builder(
            "Request",
            time: false,
            data: { status: 200, cached: false, result: nil }
        )

        assert_equal "Request status=200 cached=false result=nil", rendered
    end

    def test_empty_metadata_does_not_add_spacing
        rendered = Termline::Msg.builder("Ready", time: false, data: {})

        assert_equal "Ready", rendered
    end

    def test_alert_supports_multiple_messages
        rendered = Termline.alert("Stop", "Wait")

        assert_equal " Stop \n Wait ", rendered
        assert_equal " Stop \n Wait \n", @output.string
    end

    def test_empty_list_returns_empty_text_without_writing
        rendered = Termline.list

        assert_equal "", rendered
        assert_empty @output.string
    end

    def test_unordered_list_uses_the_selected_marker
        rendered = Termline.list("One", "Two", icon: :add, color: :green)

        assert_equal "  + One\n  + Two", rendered
    end

    def test_ordered_list_rejects_an_invalid_start
        error = assert_raises(ArgumentError) do
            Termline.ordered_list("One", start: "first")
        end

        assert_includes error.message, "integer"
    end
end
