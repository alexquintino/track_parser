require "ast"

module TrackParser
  class NameNode < AST::Node

    def initialize(name)
      super(:name, [], {raw: name})
    end

    def name
      @raw.strip
    end
  end
end
