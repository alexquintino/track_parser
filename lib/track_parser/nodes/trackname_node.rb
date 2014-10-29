require 'ast'
require_relative 'name_node'
require_relative 'remix_node'

module TrackParser
  class TracknameNode < AST::Node

    def initialize(trackname)
      super(:trackname, [], {raw: trackname})
    end

    def children
      if has_remix?
        nodes = /(?<name>.*)\((?<remix>.+)\)/.match(@raw)
        [NameNode.new(nodes[:name]), RemixNode.new(nodes[:remix])]
      else
        [NameNode.new(@raw)]
      end
    end

    def has_remix?
      !!/\(.*(#{RemixNode::VERSIONS_REGEXP})+\)/.match(@raw)
    end
  end
end
