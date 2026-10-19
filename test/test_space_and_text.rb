# frozen_string_literal: true

require "test_helper"

class TestSpaceAndText < TermlineTestCase
    def setup
        super
        Termline.ansi = false
        @output = StringIO.new
        Termline.output = @output
    end

    def test_break_writes_the_requested_number_of_newlines
        rendered = Termline.br(3)

        assert_equal "\n\n\n", rendered
        assert_equal "\n\n\n", @output.string
    end

    def test_multi_character_separator_is_cropped_to_exact_width
        rendered = Termline.line(character: "=-", width: 7)

        assert_equal "=-=-=-=", rendered
        assert_equal 7, rendered.length
    end

    def test_separator_rejects_non_positive_widths
        assert_raises(ArgumentError) { Termline::Space.line("-", 0) }
        assert_raises(ArgumentError) { Termline::Space.line("-", -1) }
    end

    def test_long_title_is_truncated_to_its_width
        rendered = Termline::Text.title("A long deployment title", width: 12)

        assert_equal "── A long d…", rendered
        assert_equal 12, rendered.length
    end

    def test_title_rejects_an_invalid_width
        assert_raises(ArgumentError) { Termline::Text.title("Title", width: 0) }
    end

    def test_title_public_helper_writes_and_returns_the_rendered_title
        rendered = Termline.title("Summary", width: 16)

        assert_equal "── Summary ─────", rendered
        assert_equal "── Summary ─────\n", @output.string
    end
end
