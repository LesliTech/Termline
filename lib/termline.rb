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


# ·
require_relative "termline/style"
require_relative "termline/table"
require_relative "termline/space"
require_relative "termline/list"
require_relative "termline/msg"


# ·
module Termline
    class << self
        def m(*messages)
            messages.each { |message| puts(message) }
        end

        def msg(*messages, **data)
            messages.each { |message| puts(Termline::Msg.builder(message, data:data)) }
        end

        def info(*messages, tag:'INFO:', icon: :info, time:true, **data)
            messages.each { |message| puts(Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :blue, time:time)) }
        end

        def success(*messages, tag:'SUCCESS:', icon: :success, time:true, **data)
            messages.each { |message| puts(Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :green, time:time)) }
        end

        def warning(*messages, tag:'WARNING:', icon: :warning, time:true, **data)
            messages.each { |message| puts(Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :yellow, time:time)) }
        end

        def danger(*messages, tag:'DANGER:', icon: :error, time:true, **data)
            messages.each { |message| puts(Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :red, time:time)) }
        end

        def alert(*messages)
            messages.each { |message| puts(Termline::Msg.alert(message)) }
        end


        def list(*items, color: :default, icon: :debug)
            Termline::List.builder(items, color:color, icon:icon)
        end


        def table(data, header:true)
            Termline::Table.builder(data, header:header)
        end

        def br(count=1)
            puts(Termline::Space.builder("\n", count))
        end 

        def line(count=8)
            puts(Termline::Space.builder('-·-     ', count))
        end

        def color(color)
            Termline::Space.color(count)
        end


        def deprecation message
        end
    end
end
