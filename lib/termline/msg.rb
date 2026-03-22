
module Termline
    module Msg 
        def self.msg messages
            puts(message)
        end

        def self.builder message, tag: 'MSG', color: :default
            puts(Config.pretty("#{tag} #{ message }", color))
        end
    
        def self.info message
            builder(message, tag:'INFO:', color: :blue)
        end

        def self.success message
            builder(message, tag:'SUCCESS:', color: :green)
        end

        def self.warning messages
            messages.each { |message| puts(Config.pretty("WARNING: #{ message }", :yellow)) }
        end

        def self.danger messages
            messages.each { |message| puts(Config.pretty("ERROR: #{ message }", :red)) }
        end

        def self.alert messages
            messages.each { |message| puts("\e[5m#{message}\e[0m") }
        end
    end
end
