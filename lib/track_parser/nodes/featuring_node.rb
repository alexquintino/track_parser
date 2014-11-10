require_relative "artist_node"
require "ast"

module TrackParser
  class FeaturingNode < AST::Node

    VERSIONS_REGEXP = ["feat.", "featuring"].join("|")

    def initialize(artists)
      super(:featuring, [], {raw: artists})
    end

    def regexp
      /\(?(#{FeaturingNode::VERSIONS_REGEXP})\s(?<artist>.*)\)?/i
    end

    def children
      artist = regexp.match(@raw)[:artist]
      [ArtistNode.new(artist)]
    end
  end
end
