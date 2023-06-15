# frozen_string_literal: true

# A bit like WebWrangler in Webview, we'll want to manage LibUI.
# We'd like to be able to manage API calls, track allocated objects, etc.
# Here's where we'll do that.

module Scarpe::Folio
  class GUI
    def GUI.create_instance(properties)
      raise "An instance already exists! One call per customer!" if @gui

      ui = LibUI
      if properties["debug"]
        ui = Scarpe::LoggedWrapper.new(ui, "LibUI")
      end
      @gui = ui
    end

    def GUI.instance
      raise("No instance created!") unless @gui
      @gui
    end
  end
end
