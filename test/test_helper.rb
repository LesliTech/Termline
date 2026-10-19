# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "termline"

require "minitest/autorun"
require "stringio"

class TermlineTestCase < Minitest::Test
    class TTYBuffer < StringIO
        def tty?
            true
        end
    end

    class SizedBuffer < StringIO
        def initialize(columns)
            super()
            @columns = columns
        end

        def winsize
            [24, @columns]
        end
    end

    def setup
        super
        Termline.output = nil
        Termline.ansi = true
        Termline.width = 80
        Termline.timestamps = true
        Termline.timestamp_format = "%H:%M:%S:%L"
    end

    def teardown
        Termline.output = nil
        Termline.ansi = :auto
        Termline.width = nil
        Termline.timestamps = true
        Termline.timestamp_format = "%H:%M:%S:%L"
        super
    end
end
