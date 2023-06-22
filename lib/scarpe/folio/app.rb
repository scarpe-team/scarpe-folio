# frozen_string_literal: true

module Scarpe::Folio
  class App < Widget
    attr_reader :debug
    attr_reader :window
    attr_writer :shoes_linkable_id
    attr_writer :document_root

    def initialize(properties)
      super

      bind_shoes_event(event_name: "init") { init }
      bind_shoes_event(event_name: "run") { run }
      bind_shoes_event(event_name: "destroy") { destroy }
    end

    # When init is called, child widgets have not yet been added
    def init
      gui.init
      @window = gui.new_window(@title, @height, @width, 1)
    end

    def run
      # Child widgets have been added, so initialize them
      @document_root.ui_init
      gui.control_show(@window)

      gui.main

      send_shoes_event(event_name: "destroy")
    end

    def destroy
      @do_shutdown = true
      #@document_root.ui_destroy_all
      gui.control_destroy(@window) if @window
      @window = nil
      gui.quit
    end
  end
end
