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

# frozen_string_literal: true

require_relative "lib/termline/version"

Gem::Specification.new do |spec|
    spec.name       = "termline"
    spec.version    = Termline::VERSION
    spec.platform    = Gem::Platform::RUBY
    spec.license     = "GPL-3.0-or-later"
    spec.authors     = ["The Lesli Development Team"]
    spec.email       = ["hello@lesli.tech"]
    spec.homepage    = "https://www.lesli.dev/"
    spec.summary     = "Human-friendly terminal logs for the Lesli Platform."
    spec.description = <<~DESC
        Termline is a lightweight Ruby gem for printing terminal messages with 
        colors, icons, and semantic log levels.
    DESC

    # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
    # to allow pushing to a single host or delete this section to allow pushing to any host.
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"]       = spec.homepage
    spec.metadata["changelog_uri"]      = "https://github.com/LesliTech/Termline/releases"
    spec.metadata["source_code_uri"]    = "https://github.com/LesliTech/Termline"
    spec.metadata["bug_tracker_uri"]    = "https://github.com/LesliTech/Termline/issues"
    spec.metadata["documentation_uri"]  = "https://www.lesli.dev/gems/termline/"

    spec.files = Dir.chdir(File.expand_path(__dir__)) do
        Dir["{lib}/**/*", "license", "readme.md"]
    end
end
