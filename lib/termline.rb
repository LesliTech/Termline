=begin

Copyright (c) 2022, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

Lesli Ruby Messages - Message utilities for the Ruby console

Powered by https://www.lesli.tech
Building a better future, one line of code at a time.

@contact  <hello@lesli.tech>
@website  <https://www.lesli.tech>
@license  GPLv3 http://www.gnu.org/licenses/gpl-3.0.en.html
@author   The Lesli Development Team

// · ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~     ~·~
// · 
=end

require "termline/config"
require "termline/table"
require "termline/space"
require "termline/list"
require "termline/msg"
require "termline/banner"


# ·
module Termline

    def self.m *messages
        messages.each { |message| Termline::Msg.msg(message) }
    end

    def self.msg (*messages)
        messages.each { |message| Termline::Msg.builder(message) }
    end

    def self.info *messages
        messages.each { |message| Termline::Msg.info(message) }
    end

    def self.success *messages
        messages.each { |message| Termline::Msg.success(message) }
    end

    def self.warning *messages
        Termline::Msg.warning(messages)
    end

    def self.danger *messages
        Termline::Msg.danger(messages)
    end

    def self.alert *messages
        Termline::Msg.alert(messages)
    end

    def self.warn *messages
        warning(messages)
    end

    def self.error *messages
        Termline::Msg.danger(messages)
    end


    def self.list *items
        Termline::List.bullet(items)
    end

    def self.list_check *items
        Termline::List.check(items)
    end

    def self.list_star *items
        Termline::List.star(items)
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
