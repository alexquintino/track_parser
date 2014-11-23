require_relative 'artist_node'
require_relative 'base_node'

module TrackParser
  class FeaturingNode < BaseNode

    VERSIONS_REGEXP = ["feat.", "featuring", "ft."].join("|")

    def initialize(artists)
      super(:featuring, artists)
    end

    def regexp
      /\(?(#{FeaturingNode::VERSIONS_REGEXP})\s(?<artist>[^\)]*)\)?/i
    end

    def children
      artist = regexp.match(@raw)[:artist]
      [ArtistsNode.new(artist)]
    end
  end
end
