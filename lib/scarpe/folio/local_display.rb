# frozen_string_literal: true

module Scarpe::Folio
  # This is an in-process ("local") LibUI-based display service.
  class DisplayService
    class << self
      attr_accessor :instance
    end

    attr_reader :app
    attr_reader :doc_root

    # This is called before any of the various widgets are created.
    def initialize
      if DisplayService.instance
        raise "ERROR! This is meant to be a singleton!"
      end

      DisplayService.instance = self

      @display_widget_for = {}
    end

    def create_display_widget_for(widget_class_name, widget_id, properties)
      if widget_class_name == "App"
        unless @doc_root
          raise "DocumentRoot is supposed to be created before App!"
        end

        display_app = Scarpe::Folio::App.new(properties)
        display_app.document_root = @doc_root
        @doc_root.app = display_app

        set_widget_pairing(widget_id, display_app)

        # For now just pass in app properties
        gui = GUI.create_instance(properties)

        return display_app
      end

      # What if it's not an App? Then create a corresponding display widget.
      display_class = Scarpe::Folio::Widget.display_class_for(widget_class_name)
      display_widget = display_class.new(properties)
      set_widget_pairing(widget_id, display_widget)

      if widget_class_name == "DocumentRoot"
        # DocumentRoot is created before App. Mostly doc_root is just like any other widget,
        # but we'll want a reference to it when we create App.
        @doc_root = display_widget
      end

      display_widget
    end

    def set_widget_pairing(id, display_widget)
      @display_widget_for[id] = display_widget
    end

    def query_display_widget_for(id, nil_ok: false)
      display_widget = @display_widget_for[id]
      unless display_widget || nil_ok
        raise "Could not find display widget for linkable ID #{id.inspect}!"
      end

      display_widget
    end

    def destroy
      @app.destroy
      WebviewDisplayService.instance = nil
    end
  end
end
