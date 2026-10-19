# frozen_string_literal: true

module Termline
    module Text
        class << self
            def title(text, color: :blue, character: "─", width: Termline.terminal.width)
                character = character.to_s
                raise ArgumentError, "Title character cannot be empty" if character.empty?

                width = positive_width(width)
                prefix = "#{character * 2} #{text}"
                plain = fit_title(prefix, character, width)

                Style.colorize(plain, color)
            end

            def key_value(data=nil, color: :blue, separator: ": ", **additional_data)
                data = additional_data if data.nil?
                data = data.merge(additional_data) if !additional_data.empty? && data.respond_to?(:merge)

                unless data.respond_to?(:each_pair)
                    raise ArgumentError, "Key-value data must be a hash-like object"
                end

                pairs = data.each_pair.to_a
                return "" if pairs.empty?

                key_width = pairs.map { |key, _value| key.to_s.length }.max
                pairs.map do |key, value|
                    label = Style.colorize(key.to_s.ljust(key_width), color)
                    "#{label}#{separator}#{format_value(value)}"
                end.join("\n")
            end

            private

            def fit_title(prefix, character, width)
                return truncate(prefix, width) if prefix.length >= width

                remaining = width - prefix.length - 1
                "#{prefix} #{fill(character, remaining)}"
            end

            def fill(character, width)
                return "" unless width.positive?

                (character * ((width.to_f / character.length).ceil))[0, width]
            end

            def truncate(text, width)
                return text if text.length <= width
                return "…" if width == 1

                "#{text[0, width - 1]}…"
            end

            def positive_width(value)
                width = Integer(value)
                raise ArgumentError unless width.positive?

                width
            rescue ArgumentError, TypeError
                raise ArgumentError, "Text width must be a positive integer"
            end

            def format_value(value)
                case value
                when nil
                    "nil"
                when String
                    value
                else
                    value.to_s
                end
            end
        end
    end
end
