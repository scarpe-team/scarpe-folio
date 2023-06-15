# frozen_string_literal: true

module Scarpe::Folio
  class App < Widget
    attr_reader :debug
    attr_writer :shoes_linkable_id
    attr_writer :document_root

    def initialize(properties)
      super

    end

  end
end