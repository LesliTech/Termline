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
    module Style 

        # Available icons
        ICONS = {
            warning: "⚠",
            success: "✔",
            debug: "•",
            error: "✖",
            info: "ℹ",
            star: "★",
            add: "+",
            remove: "-"
        }.freeze
    
        # standard color palette for texts
        COLORS = { 
            skyblue: '96',
            default: '39',
            yellow: '1;33',
            white: '1;37', 
            green: '32',  
            black: '30', 
            gray: '90',
            blue: '34',
            red: '31'
        }.freeze
    
        # standard color palette for backgrounds
        BG_COLORS = { 
            default: '49',
            yellow: '103', 
            white: '107', 
            green: '42', 
            black: '40', 
            blue: '44',
            red: '41'
        }.freeze
        class << self 
            def icon(icon)
                ICONS.fetch(icon) do
                    raise ArgumentError, "Unknown icon: #{icon.inspect}. Available icons: #{ICONS.keys.join(', ')}"
                end
            end

            # Concat color to text
            def colorize(text, colour = :default, bg_colour = :default)
                colour_code = COLORS.fetch(colour) do
                    raise ArgumentError, "Unknown color: #{colour.inspect}. Available colors: #{COLORS.keys.join(', ')}"
                end
                bg_colour_code = BG_COLORS.fetch(bg_colour) do
                    raise ArgumentError, "Unknown background color: #{bg_colour.inspect}. Available background colors: #{BG_COLORS.keys.join(', ')}"
                end
                return text.to_s unless Termline.terminal.ansi?

                return "\e[#{colour_code};#{bg_colour_code}m#{text}\e[0m"
            end

            # Format text
            def pretty(message, colour = :default, bg_colour = :default)
                width = 1
        
                unless bg_colour == :default
                    width = Termline.terminal.width - message.length - 4
                    width = 1 if width.negative?
                end
        
                return colorize("#{ message } #{"\ " * width}", colour, bg_colour)
            end
        end
    end 
end
