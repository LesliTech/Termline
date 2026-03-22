
module Termline 
    module Table 
        def self.simple data, header:true

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
        
            # print data as table :)
            data.each_with_index do |row, index|

                # only for table header
                if index == 0 && header

                    # print table titles
                    puts '| ' << row.keys.map { |key| key.to_s.upcase.ljust(col_width) }.join('| ')

                    # print header separators, only for visible columns
                    puts separator * (cols - 1)

                end 

                # join hash values as a line and justify every value to print value in its own column
                puts '| ' << row.values.map { |value| value.to_s.ljust(col_width) }.join('| ') unless table_from_array

                # print simple value from the array data
                puts '| ' << row.map { |value| value.to_s.ljust(col_width) }.join('| ') if table_from_array
            end
        end
    end
end
