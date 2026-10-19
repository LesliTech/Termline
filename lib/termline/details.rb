# frozen_string_literal: true

module Termline
    module Details
        class << self
            def builder(data=nil, color: :blue, separator: ": ", icon: nil, icons: nil, **additional_data)
                data = additional_data if data.nil?
                data = data.merge(additional_data) if !additional_data.empty? && data.respond_to?(:merge)

                unless data.respond_to?(:each_pair)
                    raise ArgumentError, "Details data must be a hash-like object"
                end

                pairs = data.each_pair.to_a
                return "" if pairs.empty?

                icon_map = normalize_icon_map(icons)
                show_icon_column = !icon.nil? || !icon_map.empty?
                key_width = pairs.map { |key, _value| key.to_s.length }.max

                pairs.map do |key, value|
                    row_icon = icon_map.fetch(key.to_s, icon)
                    icon_prefix = format_icon(row_icon, color, show_icon_column)
                    label = Style.colorize(key.to_s.ljust(key_width), color)
                    "#{icon_prefix}#{label}#{separator}#{format_value(value)}"
                end.join("\n")
            end

            private

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

            def normalize_icon_map(icons)
                return {} if icons.nil?

                unless icons.respond_to?(:each_pair)
                    raise ArgumentError, "Details icons must be a hash-like object"
                end

                icons.each_pair.each_with_object({}) do |(key, value), normalized|
                    normalized[key.to_s] = value
                end
            end

            def format_icon(icon, color, show_icon_column)
                return "" unless show_icon_column
                return "  " if icon.nil?

                "#{Style.colorize(Style.icon(icon), color)} "
            end
        end
    end
end
