# frozen_string_literal: true

require_relative "folio/version"
require "scarpe"
require "scarpe/folio/local_display"

module Scarpe::Folio
  #class Error < StandardError; end
end

# For now there is only local, no remote
Scarpe::DisplayService.set_display_service_class(Scarpe::Folio::DisplayService)
