# frozen_string_literal: true

require "test_helper"

class TestTermline < Minitest::Test
    def test_that_it_has_a_version_number
        refute_nil ::Termline::VERSION
    end

    def test_msg
        assert_equal ["Testing info"], Termline.info("Testing info")
    end
end
