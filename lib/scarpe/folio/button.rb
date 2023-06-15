# frozen_string_literal: true

module Scarpe::Folio
  class Button < Widget
    def initialize(properties)
      super
    end

    def ui_init
      @button = gui.new_button(@text)
      gui.box_append(@parent.ui_widget, @button, 0)
    end

    def ui_destroy
      gui.control_destroy(@button) if @button
    end
  end
end
