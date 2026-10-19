# frozen_string_literal: true

require "test_helper"

class TestTable < TermlineTestCase
    def setup
        super
        Termline.ansi = false
    end

    def test_single_hash_is_rendered_as_one_row
        table = Termline::Table.builder({ name: "Ada", score: 10 })

        assert_equal "| NAME | SCORE |\n|------|-------|\n| Ada  |    10 |", table
    end

    def test_hash_rows_use_the_union_of_their_keys
        table = Termline::Table.builder([
            { name: "Ada" },
            { name: "Grace", language: "COBOL" }
        ])

        assert_includes table, "LANGUAGE"
        assert_match(/\| Ada\s+\|\s+\|/, table)
        assert_includes table, "COBOL"
    end

    def test_active_record_relation_is_serialized_without_a_runtime_dependency
        skip "Active Record is already loaded" if Object.const_defined?(:ActiveRecord)

        active_record = Module.new
        relation_class = Class.new(Array)
        active_record.const_set(:Relation, relation_class)
        Object.const_set(:ActiveRecord, active_record)

        record = Object.new
        record.define_singleton_method(:serializable_hash) { { name: "Ada" } }

        table = Termline::Table.builder(relation_class.new([record]))

        assert_includes table, "NAME"
        assert_includes table, "Ada"
    ensure
        Object.send(:remove_const, :ActiveRecord) if defined?(active_record) && Object.const_get(:ActiveRecord) == active_record
    end

    def test_array_rows_are_padded_to_the_longest_row
        table = Termline::Table.builder([["a"], ["b", "c"]])

        assert_equal "|---|---|\n| a |   |\n| b | c |\n|---|---|", table
    end

    def test_hash_header_can_be_disabled
        table = Termline::Table.builder([{ name: "Ada" }], header: false)

        assert_equal "|-----|\n| Ada |\n|-----|", table
    end

    def test_global_center_alignment_is_applied
        table = Termline::Table.builder([{ name: "A" }, { name: "Ada" }], align: :center)

        assert_includes table, "|  A   |"
    end

    def test_alignment_array_is_applied_by_position
        table = Termline::Table.builder([["A", 2]], align: [:right, :left])

        assert_equal "|---|---|\n| A | 2 |\n|---|---|", table
    end

    def test_alignment_hash_accepts_a_string_version_of_a_symbol_key
        table = Termline::Table.builder([{ score: 9 }, { score: 100 }], align: { "score" => :left })

        assert_includes table, "| 9     |"
    end

    def test_invalid_alignment_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Table.builder([{ name: "Ada" }], align: :diagonal)
        end

        assert_includes error.message, "Unknown table alignment"
    end

    def test_mixed_row_types_are_rejected
        error = assert_raises(ArgumentError) do
            Termline::Table.builder([{ name: "Ada" }, ["Grace"]])
        end

        assert_includes error.message, "all be hashes or all be arrays"
    end

    def test_unsupported_data_is_rejected
        error = assert_raises(ArgumentError) do
            Termline::Table.builder(42)
        end

        assert_includes error.message, "hash or collection"
    end

    def test_newlines_are_collapsed_inside_cells
        table = Termline::Table.builder([{ message: "one\ntwo" }])

        assert_includes table, "one two"
        assert_equal 3, table.lines.length
    end

    def test_table_returns_empty_when_borders_leave_no_cell_space
        Termline.width = 7

        assert_equal "", Termline::Table.builder([["a", "b"]])
    end

    def test_every_ascii_line_fits_the_terminal_width
        Termline.width = 24

        table = Termline::Table.builder([
            { name: "A very long name", score: 100 },
            { name: "Ada", score: 9 }
        ])

        assert table.lines.all? { |line| line.chomp.length <= 24 }
        assert_includes table, "…"
    end
end
