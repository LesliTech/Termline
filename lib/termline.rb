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
require_relative "termline/text"
require_relative "termline/details"


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

        def timestamps
            @timestamps.nil? ? true : @timestamps
        end

        alias timestamps? timestamps

        def timestamps=(value)
            unless value == true || value == false
                raise ArgumentError, "Timestamps must be true or false"
            end

            @timestamps = value
        end

        def timestamp_format
            @timestamp_format || "%H:%M:%S:%L"
        end

        def timestamp_format=(format)
            unless format.is_a?(String) && !format.empty?
                raise ArgumentError, "Timestamp format must be a non-empty string"
            end

            @timestamp_format = format
        end

        def configure
            yield self
            self
        end

        def m(*messages)
            write(messages.map(&:to_s).join("\n"))
        end

        def msg(*messages, time:nil, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, bgcolor:bgcolor, data:data, time:time) }.join("\n"))
        end

        def info(*messages, tag:'INFO:', icon: :info, time:nil, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :blue, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def success(*messages, tag:'SUCCESS:', icon: :success, time:nil, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :green, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def warning(*messages, tag:'WARNING:', icon: :warning, time:nil, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :yellow, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def danger(*messages, tag:'DANGER:', icon: :error, time:nil, bgcolor: :default, **data)
            write(messages.map { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :red, bgcolor:bgcolor, time:time) }.join("\n"))
        end

        def alert(*messages)
            write(messages.map { |message| Termline::Msg.alert(message) }.join("\n"))
        end


        def list(*items, color: :default, icon: :debug)
            write(Termline::List.builder(items, color:color, icon:icon))
        end

        def ordered_list(*items, color: :default, start: 1)
            write(Termline::List.builder(items, color:color, ordered:true, start:start))
        end

        def table(data, header:true, align: :auto)
            write(Termline::Table.builder(data, header:header, align:align))
        end

        def br(count=1)
            write(Termline::Space.builder("\n", count))
        end 

        def line(count=nil, character: "─", width: nil)
            content = if count
                Termline::Space.builder('-·-     ', count)
            else
                Termline::Space.line(character, width || terminal.width)
            end

            write(content)
        end

        def color(color)
            write(Termline::Space.color(color))
        end


        def title(text, color: :blue, character: "─", width: nil)
            write(Termline::Text.title(text, color:color, character:character, width:width || terminal.width))
        end

        def details(data=nil, color: :blue, separator: ": ", icon: nil, icons: nil, **pairs)
            write(Termline::Details.builder(
                data,
                color:color,
                separator:separator,
                icon:icon,
                icons:icons,
                **pairs
            ))
        end

        def deprecation(*messages, time:nil, **data)
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
