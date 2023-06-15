# frozen_string_literal: true

require "test_helper"

class Scarpe::TestFolio < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Scarpe::Folio::VERSION
  end
end
