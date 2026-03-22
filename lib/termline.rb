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

require_relative "termline/style"
require_relative "termline/table"
require_relative "termline/space"
require_relative "termline/list"
require_relative "termline/msg"
require_relative "termline/banner"


# ·
module Termline

    def self.m *messages
        messages.each { |message| puts(message) }
    end

    def self.msg (*messages, **data)
        messages.each { |message| Termline::Msg.builder(message, data:data) }
    end

    def self.info *messages, tag:'INFO:', icon: :info, **data
        messages.each { |message| Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :blue) }
    end

    def self.success *messages, tag:'SUCCESS:', icon: :success, **data
        messages.each { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :green) }
    end

    def self.success2 *messages, tag:'SUCCESS:', icon: :success, **data
        messages.each { |message| Termline::Msg.builder(message, tag:tag, icon:icon, data:data, color: :green) }
    end

    def self.warning *messages, tag:'WARNING:', icon: :warning, **data
        messages.each { |message| Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :yellow) }
    end

    def self.danger *messages, tag:'DANGER:', icon: :error, **data
        messages.each { |message| Termline::Msg.builder(message, tag:tag, icon:icon,  data:data, color: :red) }
    end

    def self.alert *messages
        messages.each { |message| Termline::Msg.alert(message) }
    end


    def self.list *items, color: :default, icon: :debug
        Termline::List.builder(items, color:color, icon:icon)
    end


    def self.table data, header:true
        Termline::Table.simple(data, header:header)
    end

    def self.br count=1
        Termline::Space.br(count)
    end 

    def self.line count=8
        Termline::Space.line(count)
    end

    def self.color color
        Termline::Space.color(count)
    end


    def self.deprecation message
    end
end
