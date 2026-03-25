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
            def builder data, header:true

                return if Gem.win_platform?
                return unless data.size > 0

                table_from_array = true if data.first.class == Array
                header = false if table_from_array

                if data.class.name == "ActiveRecord::Relation"
                    data = data.to_a.map(&:serializable_hash) 
                end

                # get the available characters in terminal width
                #terminal_width = `tput cols`.to_i
                terminal_width = Style::WIDTH

                # get the number of columns to print base on the data hash
                cols = data.first.length + 1

                # get the available space for every column
                col_width = (terminal_width / cols) - 1

                # validate that we have minimum space to render the table
                return if col_width <= 0

                # separator for every column and row
                separator = ('| ' << ('- ' * (col_width / 2)))

                # add extra blank spaces to adjust the col_width only if col_width not a even number
                separator += (' ') if (col_width - separator.size).odd?

                # only for table header
                if header

                    # print table titles
                    puts '| ' << data.first.keys.map { |key| key.to_s.upcase.ljust(col_width) }.join('| ')
                end 

                # print header separators, only for visible columns
                puts separator * (cols - 1)

                # print data as table :)
                data.each_with_index do |row, index|

                    # join hash values as a line and justify every value to print value in its own column
                    puts '| ' << row.values.map { |value| value.to_s.ljust(col_width) }.join('| ') unless table_from_array

                    # print simple value from the array data
                    puts '| ' << row.map { |value| value.to_s.ljust(col_width) }.join('| ') if table_from_array
                end

                puts separator * (cols - 1) unless header
            end
        end
    end
end
