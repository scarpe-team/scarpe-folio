# frozen_string_literal: true

# A bit like WebWrangler in Webview, we'll want to manage LibUI.
# We'd like to be able to manage API calls, track allocated objects, etc.
# Here's where we'll do that.

# TODO: would be really good to track created windows and widgets.
# Destruction-tracking would be really good to avoid leaks. Might
# even need handler tracking or similar to make sure we have refs
# to all appropriate stuff.

module Scarpe::Folio
  class GUI
    def GUI.create_instance(properties)
      raise "An instance already exists! One call per customer!" if @gui

      ui = LibUI
      if properties["debug"]
        ui = Scarpe::LoggedWrapper.new(ui, "LibUI")
      end
      @gui = GUI.new(ui)
    end

    def GUI.instance
      raise("No instance created!") unless @gui
      @gui
    end

    def initialize(libui)
      @libui = libui
    end

    def method_missing(name, *args, **kwargs, &block)
      $stderr.puts "Calling: #{name.inspect} A: #{args.inspect} KW: #{kwargs.inspect} b: #{block ? "y" : "n"}"
      @libui.send(name, *args, **kwargs, &block)
    end
  end
end

# Over time, this should grow into a more comprehensive wrapper around kojix2/libui, which is meant to
# be wrapped, not used directly.

# References:

# Examples for libui-ng underlying C lib: https://github.com/libui-ng/libui-ng/tree/master/examples

# LibUI FFI code: https://github.com/kojix2/LibUI/blob/main/lib/libui/ffi.rb
# libui-ng's ui.h header: https://github.com/libui-ng/libui-ng/blob/master/ui.h
# AndLabs' Go package documentation: https://pkg.go.dev/github.com/andlabs/ui

# Glimmer has a LibUI wrapper which can sometimes be helpful to reference: https://github.com/AndyObtiva/glimmer-dsl-libui/blob/master/README.md

# There's some weirdness with the available event-loop functions, such as uiMainStep and uiMainSteps, which
# may explain why Go doesn't wrap them... I suspect we'll want a remote/relay display service for libui just
# like we do for Webview, for roughly the same reasons.
#
# * https://github.com/andlabs/libui/issues/95
# * https://github.com/andlabs/libui/issues/125
