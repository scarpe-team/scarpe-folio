# frozen_string_literal: true

require "libui"

require_relative "folio/version"

# Scarpe can require us... But if it doesn't, we should first require scarpe.
unless defined?(Scarpe::VERSION)
  require "scarpe"
end

require "scarpe/folio/gui"
require "scarpe/folio/widget"
require "scarpe/folio/document_root"
require "scarpe/folio/app"
require "scarpe/folio/button"
require "scarpe/folio/alert"
require "scarpe/folio/local_display"

module Scarpe::Folio
  #class Error < StandardError; end
end

# For now there is only local, no remote
Scarpe::DisplayService.set_display_service_class(Scarpe::Folio::DisplayService)
