=begin

Lesli

Copyright (c) 2026, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.

Lesli · Ruby on Rails SaaS Development Framework.

Made with ♥ by LesliTech
Building a better future, one line of code at a time.

@contact  hello@lesli.tech
@website  https://www.lesli.tech
@license  GPLv3 http://www.gnu.org/licenses/gpl-3.0.en.html

// · ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~
// · 
=end

module Termline 
    module Table 
        class << self
            ALIGNMENTS = [:auto, :left, :center, :right].freeze

            def builder(data, header:true, align: :auto)
                # Convert every supported input into a predictable matrix first.
                # Rendering can then stay independent from Active Record and hashes.
                source = normalize_source(data)
                return "" if source.empty?

                keys, rows, hash_rows = normalize_rows(source)
                return "" if rows.empty? || rows.first.empty?

                headers = hash_rows && header ? keys.map { |key| key.to_s.upcase } : nil
                text_rows = rows.map { |row| row.map { |value| normalize_value(value) } }

                # Widths are calculated from visible text before padding or borders
                # are added, so the completed line never exceeds the terminal width.
                widths = column_widths(text_rows, headers, Termline.terminal.width)
                return "" unless widths

                alignments = widths.each_index.map do |index|
                    column_alignment(align, index, keys[index], rows.map { |row| row[index] })
                end

                separator = render_separator(widths)
                lines = []

                if headers
                    lines << render_row(headers, widths, alignments)
                    lines << separator
                else
                    lines << separator
                end

                text_rows.each do |row|
                    lines << render_row(row, widths, alignments)
                end

                lines << separator unless headers
                lines.join("\n")
            end

            private

            def normalize_source(data)
                # A single hash is one row. Active Record support is detected only
                # when Active Record is already loaded, keeping it an optional dependency.
                return [] if data.nil?
                return [data] if data.is_a?(Hash)

                if active_record_relation?(data)
                    return data.to_a.map(&:serializable_hash)
                end

                unless data.respond_to?(:to_a)
                    raise ArgumentError, "Table data must be a hash or collection of rows"
                end

                data.to_a
            end

            def active_record_relation?(data)
                defined?(::ActiveRecord::Relation) && data.is_a?(::ActiveRecord::Relation)
            end

            def normalize_rows(source)
                if source.all? { |row| row.is_a?(Hash) }
                    # Use the union of keys in insertion order. This preserves columns
                    # that appear only in later rows and leaves missing values blank.
                    keys = source.flat_map(&:keys).uniq
                    rows = source.map { |row| keys.map { |key| row[key] } }
                    return [keys, rows, true]
                end

                unless source.all? { |row| row.is_a?(Array) }
                    raise ArgumentError, "Table rows must all be hashes or all be arrays"
                end

                # Array rows have no column names. Pad short rows so every rendered
                # row has the same number of cells and borders remain aligned.
                column_count = source.map(&:length).max.to_i
                rows = source.map { |row| row + Array.new(column_count - row.length) }
                [Array.new(column_count) { |index| index }, rows, false]
            end

            def normalize_value(value)
                # Tables are intentionally single-line components; embedded whitespace
                # is collapsed instead of allowing one value to break the layout.
                value.nil? ? "" : value.to_s.gsub(/\s+/, " ").strip
            end

            def column_widths(rows, headers, terminal_width)
                column_count = rows.first.length

                # Each column contributes two padding spaces and one separator.
                # The final `+ 1` accounts for the closing border.
                available = terminal_width - ((column_count * 3) + 1)
                return nil if available < column_count

                widths = Array.new(column_count, 1)
                column_count.times do |index|
                    values = rows.map { |row| row[index].length }
                    values << headers[index].length if headers
                    widths[index] = values.max
                end

                # Repeatedly shrink the widest column. This favors compact columns
                # while sharing scarce space fairly between long text columns.
                while widths.sum > available
                    index = widths.each_index.select { |position| widths[position] > 1 }.max_by { |position| widths[position] }
                    break unless index

                    widths[index] -= 1
                end

                widths
            end

            def column_alignment(align, index, key, values)
                # Alignment may be global, positional, or keyed by the original hash
                # key. Missing per-column settings fall back to automatic alignment.
                requested = case align
                when Hash
                    align.fetch(key) do
                        align.fetch(key.to_s) { align.fetch(index, :auto) }
                    end
                when Array
                    align[index] || :auto
                else
                    align
                end

                requested = requested.to_sym if requested.respond_to?(:to_sym)
                unless ALIGNMENTS.include?(requested)
                    raise ArgumentError, "Unknown table alignment: #{requested.inspect}. Available alignments: #{ALIGNMENTS.join(', ')}"
                end

                return requested unless requested == :auto

                # A column is numeric only when all of its non-nil source values are
                # numeric. Numeric-looking strings remain left-aligned intentionally.
                printable_values = values.compact
                printable_values.any? && printable_values.all? { |value| value.is_a?(Numeric) } ? :right : :left
            end

            def render_separator(widths)
                "|#{widths.map { |width| "-" * (width + 2) }.join("|")}|"
            end

            def render_row(row, widths, alignments)
                cells = row.each_index.map do |index|
                    text = truncate(row[index], widths[index])
                    align_text(text, widths[index], alignments[index])
                end

                "| #{cells.join(' | ')} |"
            end

            def truncate(text, width)
                return text if text.length <= width
                return "…" if width == 1

                # Reserve the final cell for an ellipsis so truncation is visible.
                "#{text[0, width - 1]}…"
            end

            def align_text(text, width, alignment)
                case alignment
                when :right
                    text.rjust(width)
                when :center
                    text.center(width)
                else
                    text.ljust(width)
                end
            end
        end
    end
end
