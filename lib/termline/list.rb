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
    module List 
        class << self
            def builder(items, icon: :debug, color: :default, ordered: false, start: 1)
                first_number = integer_start(start)

                items.each_with_index.map do |item, index|
                    marker = if ordered
                        Style.colorize("#{first_number + index}.", color)
                    else
                        Style.colorize(Style.icon(icon), color)
                    end

                    "  #{marker} #{item}"
                end.join("\n")
            end

            private

            def integer_start(value)
                Integer(value)
            rescue ArgumentError, TypeError
                raise ArgumentError, "List start must be an integer"
            end
        end
    end
end 
