# frozen_string_literal: true

module Scarpe::Folio
  class DocumentRoot < Widget
    def initialize(properties)
      @callbacks = {}

      super
    end

    # No bind or handle_callback or redraw or handler...
  end
end
