# frozen_string_literal: true

require "test_helper"

class TestDetails < TermlineTestCase
    def setup
        super
        Termline.ansi = false
        @output = StringIO.new
        Termline.output = @output
    end

    def test_builder_aligns_labels
        rendered = Termline::Details.builder(environment: "production", version: "1.2")

        assert_equal "environment: production\nversion    : 1.2", rendered
    end

    def test_builder_accepts_a_hash_and_additional_pairs
        rendered = Termline::Details.builder({ name: "Termline" }, version: "1.1.2")

        assert_equal "name   : Termline\nversion: 1.1.2", rendered
    end

    def test_additional_details_override_hash_values
        rendered = Termline::Details.builder({ status: "pending" }, status: "ready")

        assert_equal "status: ready", rendered
    end

    def test_public_helper_writes_and_returns_the_rendered_details
        rendered = Termline.details(
            { environment: "production", workers: 4 },
            icon: :info
        )

        assert_equal "ℹ environment: production\nℹ workers    : 4", rendered
        assert_equal "ℹ environment: production\nℹ workers    : 4\n", @output.string
    end

    def test_icons_accept_string_or_symbol_keys
        rendered = Termline::Details.builder(
            { status: "ready", workers: 4 },
            icon: :info,
            icons: { "status" => :success, workers: :star }
        )

        assert_equal "✔ status : ready\n★ workers: 4", rendered
    end

    def test_missing_icons_keep_labels_aligned
        rendered = Termline::Details.builder(
            { status: "ready", workers: 4 },
            icons: { status: :success }
        )

        assert_equal "✔ status : ready\n  workers: 4", rendered
    end

    def test_invalid_icon_map_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Details.builder({ status: "ready" }, icons: :success)
        end

        assert_includes error.message, "hash-like"
    end

    def test_unknown_icon_is_rejected
        assert_raises(ArgumentError) do
            Termline::Details.builder({ status: "ready" }, icon: :missing)
        end
    end

    def test_nil_values_are_formatted_with_icons
        rendered = Termline::Details.builder({ status: nil }, icon: :info)

        assert_equal "ℹ status: nil", rendered
    end

    def test_empty_details_do_not_write
        rendered = Termline.details({})

        assert_equal "", rendered
        assert_empty @output.string
    end

    def test_non_hash_data_is_rejected
        error = assert_raises(ArgumentError) { Termline.details("status") }

        assert_includes error.message, "hash-like"
    end
end
