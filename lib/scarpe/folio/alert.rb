# frozen_string_literal: true

module Scarpe::Folio
  class Alert < Widget
    def initialize(properties)
      super
    end

    def ui_init
      gui.msg_box(app.window, "Message Box", @text)
    end
  end
end
