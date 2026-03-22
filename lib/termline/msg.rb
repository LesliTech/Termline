
module Termline
    module Msg 
        class << self

            def builder(
                message, 
                tag: nil,
                icon: nil,
                color: :default, 
                bgcolor: :default, 
                timestamp: Time.now.strftime('%H:%M:%S:%L'), data:nil)

                parts = []
                parts << "[#{timestamp}]" if timestamp
                parts << Style.colorize(Style.icon(icon), color) if icon
                parts << Style.colorize(tag, color) if tag
                parts << message
                parts << data_text(data, color) if data

                puts(parts.compact.map(&:to_s).reject(&:empty?).join(" ").strip)
            end

            def alert message
                puts("\e[5m#{message}\e[0m")
                puts("\e[5m#{Style.colorize(message,:red)}\e[0m")
            end

            private 

            def format_value(value)
                case value
                when String
                    value.include?(" ") ? value.inspect : value
                else
                    value.inspect
                end
            end

            def data_text(data, color)
                return nil if data.nil? || data.empty?
                data.map { |key, value| "#{key}#{Style.colorize('=>', color)}#{format_value(value)}" }.join(" ")            
            end
        end
    end
end
