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
require_relative "termline/version"
require_relative "termline/terminal"
require_relative "termline/style"
require_relative "termline/table"
require_relative "termline/space"
require_relative "termline/list"
require_relative "termline/msg"


# ·
module Termline
    class << self
        def terminal
            @terminal ||= Termline::Terminal.new
        end

        def output
            terminal.output
        end

        def output=(io)
            terminal.output = io
        end

        def ansi
            terminal.ansi
        end

        def ansi=(mode)
            terminal.ansi = mode
        end

        def width
            terminal.width
        end

        def width=(value)
            terminal.width = value
        end

        def m(*messages)
            write(messages.map(&:to_s).join("\n"))
        end

        def msg(*messages, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, bgcolor:bgcolor, data:data) }.join("\n"))
        end

        def info(*messages, tag:'INFO:', icon: :info, time:true, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :blue, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def success(*messages, tag:'SUCCESS:', icon: :success, time:true, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :green, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def warning(*messages, tag:'WARNING:', icon: :warning, time:true, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :yellow, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def danger(*messages, tag:'DANGER:', icon: :error, time:true, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :red, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def alert(*messages)
            write(messages.map { |message| Termline::Msg.alert(message) }.join("\n"))
        end


        def list(*items, color: :default, icon: :debug)
            write(Termline::List.builder(items, color:color, icon:icon))
        end


        def table(data, header:true)
            write(Termline::Table.builder(data, header:header))
        end

        def br(count=1)
            write(Termline::Space.builder("\n", count))
        end 

        def line(count=8)
            write(Termline::Space.builder('-·-     ', count))
        end

        def color(color)
            write(Termline::Space.color(color))
        end


        def deprecation(*messages, time:true, **data)
            warning(*messages, tag: 'DEPRECATED:', time:time, **data)
        end

        private

        def write(content)
            return content if content.nil? || content.empty?

            output.puts(content)
            content
        end
    end
end
