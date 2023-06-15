# frozen_string_literal: true

module Scarpe::Folio
  class DocumentRoot < Widget
    attr_writer :app

    def initialize(properties)
      @callbacks = {}

      super
    end

    def ui_init
      raise("No app set before ui_init!") unless @app

      window = @app.window

      @vbox = gui.new_vertical_box

      gui.window_on_closing(window) do
        puts "Window was closed..."
        @app.destroy
        0
      end

      children.each(&:ui_init)

      gui.window_set_child(window, @vbox)
    end

    # Widget to add children to
    def ui_widget
      @vbox
    end

    def ui_destroy
      gui.control_destroy(@app.window) if @app.window
    end
  end
end
