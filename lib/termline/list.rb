
module Termline 
    module List 
        def self.builder(items, icon:, color:)
            items.each { |item| puts("  #{Style.colorize(Style.icon(icon), color)} #{ item }" )}
        end
    end
end 
