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
    module Msg 
        class << self

            def builder(
                message, 
                tag: nil,
                icon: nil,
                color: :default, 
                bgcolor: :default, 
                timestamp: Time.now.strftime('%H:%M:%S:%L'), 
                time:true,
                data:nil)

                parts = []
                parts << "[#{timestamp}]" if time
                parts << Style.colorize(Style.icon(icon), color) if icon
                parts << Style.colorize(tag, color) if tag
                parts << if bgcolor == :default
                    message
                else
                    Style.colorize(message, color, bgcolor)
                end
                parts << data_text(data, color) if data

                parts.compact.map(&:to_s).reject(&:empty?).join(" ").strip
            end

            def alert(message)
                Style.colorize(" #{message} ", :white, :red)
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
