# frozen_string_literal: true

require "io/console"

module Termline
    class Terminal
        DEFAULT_WIDTH = 80
        ANSI_MODES = [true, false, :auto].freeze

        attr_reader :ansi

        def initialize(output: nil, ansi: :auto, width: nil)
            self.output = output
            self.ansi = ansi
            self.width = width
        end

        def output
            @output || $stdout
        end

        def output=(io)
            unless io.nil? || io.respond_to?(:puts)
                raise ArgumentError, "Output must respond to #puts"
            end

            @output = io
        end

        def ansi=(mode)
            unless ANSI_MODES.include?(mode)
                raise ArgumentError, "ANSI mode must be true, false, or :auto"
            end

            @ansi = mode
        end

        def ansi?
            return ansi if ansi == true || ansi == false

            output.respond_to?(:tty?) && output.tty? && !ENV.key?("NO_COLOR") && ENV["TERM"] != "dumb"
        end

        def width
            return @width if @width

            width_from(output) || environment_width || width_from(IO.console) || DEFAULT_WIDTH
        end

        def width=(value)
            if value.nil?
                @width = nil
                return
            end

            width = Integer(value)
            raise ArgumentError, "Terminal width must be greater than zero" unless width.positive?

            @width = width
        rescue ArgumentError, TypeError
            raise ArgumentError, "Terminal width must be a positive integer"
        end

        private

        def environment_width
            value = Integer(ENV.fetch("COLUMNS", 0))
            value if value.positive?
        rescue ArgumentError, TypeError
            nil
        end

        def width_from(io)
            return unless io.respond_to?(:winsize)

            value = io.winsize.last.to_i
            value if value.positive?
        rescue IOError, SystemCallError
            nil
        end
    end
end
