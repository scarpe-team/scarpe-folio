# frozen_string_literal: true

module Scarpe::Folio
  class App < Widget
    attr_reader :debug
    attr_writer :shoes_linkable_id
    attr_writer :document_root

    def initialize(properties)
      super

      bind_display_event(event_name: "init") { init }
      bind_display_event(event_name: "run") { run }
      bind_display_event(event_name: "destroy") { destroy }
    end

    def init
    end

    def run
      STDERR.puts "Need an event loop, not just a stand-in."
      exit 0

      # Wait for incoming events from background threads, if any
      until @do_shutdown
        sleep 0.1
      end
    end

    def destroy
      @do_shutdown = true
    end
  end
end
