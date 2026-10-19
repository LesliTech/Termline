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
        end
    end
end
