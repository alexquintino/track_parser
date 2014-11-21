require 'ast'

module TrackParser
  class BaseNode < AST::Node

    def initialize(type, text)
      super(type, [], {raw: text})
    end
  end
end
