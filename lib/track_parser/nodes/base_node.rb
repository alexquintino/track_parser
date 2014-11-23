require 'ast'
require_relative 'empty_node'

module TrackParser
  class BaseNode < AST::Node

    def self.new(text)
      return EmptyNode.new if text.strip.empty?
      super(text)
    end

    def initialize(type, text)
      super(type, [], {raw: text})
    end
  end
end