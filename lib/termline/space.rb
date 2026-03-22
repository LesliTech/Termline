
module Termline 
    module Space 

        def self.br count=1
            puts("\n" * count);
        end 
    
        def self.line count=8
            puts('-·-     ' * count)
        end

        def self.color color
            Config.pretty("", :black, color)
        end
    end
end
