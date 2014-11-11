require_relative "artist_node"
require "ast"

module TrackParser
  class ArtistsNode < AST::Node

    def initialize(artists)
      super(:artists, [], {raw: artists})
    end

    def children
      if multiple?
        /(.*) (?:and|&)+ (.*)/.match(@raw).captures.map { |capture| ArtistNode.new(capture) }
      else
        [ArtistNode.new(@raw)]
      end
    end

    def multiple?
      !!/\s(?:and|&)\s/i.match(@raw)
    end
  end
end
