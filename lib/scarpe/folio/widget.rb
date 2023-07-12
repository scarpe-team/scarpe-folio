# frozen_string_literal: true

module Scarpe::Folio
  class Widget < ::Shoes::Linkable
    include Shoes::Log

    class << self
      def display_class_for(scarpe_class_name)
        shoes_class = Shoes.const_get(scarpe_class_name)
        unless shoes_class.ancestors.include?(::Shoes::Linkable)
          raise "Can only get display classes for Shoes " +
            "linkable widgets, not #{shoes_class_name.inspect}!"
        end

        klass = Scarpe::Folio.const_get(shoes_class.name.split("::")[-1])
        if klass.nil?
          raise "Couldn't find corresponding display class for #{shoes_class_name.inspect}!"
        end

        klass
      end
    end

    attr_reader :shoes_linkable_id
    attr_reader :parent
    attr_reader :initialized

    def initialize(properties)
      log_init("Folio::Widget")

      @initialized = false # Haven't yet called ui_init

      # Call method, which looks up the parent
      @shoes_linkable_id = properties["shoes_linkable_id"] || properties[:shoes_linkable_id]
      unless @shoes_linkable_id
        raise "Could not find property shoes_linkable_id in #{properties.inspect}!"
      end

      # Set the display properties
      properties.each do |k, v|
        next if k == "shoes_linkable_id"

        instance_variable_set("@" + k.to_s, v)
      end

      # The parent field is *almost* simple enough that a typed display property would handle it.
      bind_shoes_event(event_name: "parent", target: shoes_linkable_id) do |new_parent_id|
        display_parent = DisplayService.instance.query_display_widget_for(new_parent_id)
        if @parent != display_parent
          set_parent(display_parent)
        end
      end

      # When Shoes widgets change properties, we get a change notification here
      bind_shoes_event(event_name: "prop_change", target: shoes_linkable_id) do |prop_changes|
        prop_changes.each do |k, v|
          instance_variable_set("@" + k, v)
        end
        properties_changed(prop_changes)
      end

      bind_shoes_event(event_name: "destroy", target: shoes_linkable_id) do
        destroy_self
      end

      super()
    end

    # This exists to be overridden by children watching for changes
    def properties_changed(changes)
      raise("Don't know how to handle property changes: #{changes.inspect}") unless changes.empty?
    end

    def set_parent(new_parent)
      @parent = new_parent
      @parent&.remove_child(self)
      new_parent&.add_child(self)
    end

    def children
      @children ||= []
    end

    protected

    # By default, use @window if set or ask our parent for
    # their window. The document root has a window set.
    def window
      @window || @parent.window
    end

    def app
      @app || @parent.app
    end

    def gui
      @gui ||= GUI.instance
    end

    def ui_init
      return if @initialized
      @initialized = true
      children.each do |child|
        child.ui_init unless child.initialized
      end
    end

    def ui_destroy_all
      # TODO: uncomment
      #children.each do |child|
      #  child.ui_destroy if child.initialized
      #end
      #ui_destroy
    end

    # Do not call directly, use set_parent
    def remove_child(child)
      @children ||= []
      unless @children.include?(child)
        @log.error("remove_child: no such child(#{child.inspect}) for"\
          " parent(#{parent.inspect})!")
      end
      @children.delete(child)
    end

    # Do not call directly, use set_parent
    def add_child(child)
      @children ||= []
      @children << child

      if @initialized
        child.ui_init
      end
    end

    # How do we do update for LibUI? *Do* we?
    def needs_update!
    end

  end
end
