# frozen_string_literal: true

module Scarpe::Folio
  class Button < Widget
    def initialize(properties)
      super
    end

    def ui_init
      @button = gui.new_button(@text)
      gui.button_on_clicked(@button) do
        send_display_event(event_name: "click", target: shoes_linkable_id)
      end
      gui.box_append(@parent.ui_widget, @button, 0)

      super
    end

    def ui_destroy
      gui.control_destroy(@button) if @button
    end
  end
end
