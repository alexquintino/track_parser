require_relative "artist_node"
require "ast"

module TrackParser
  class ArtistsNode < AST::Node

    def initialize(artists)
      super(:artists, [], {raw: artists})
    end

    def children
      if @raw.include?("&")
        /(.*) &+ (.*)/.match(@raw).captures.map { |capture| ArtistNode.new(capture) }
      else
        [ArtistNode.new(@raw)]
      end
    end
  end
end
