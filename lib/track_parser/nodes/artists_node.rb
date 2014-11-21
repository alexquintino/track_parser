require_relative 'artist_node'
require_relative 'base_node'

module TrackParser
  class ArtistsNode < BaseNode

    def initialize(artists)
      super(:artists, artists)
    end

    def children
      if multiple?
        @raw.split(regex).map { |capture| ArtistNode.new(capture) }
      else
        [ArtistNode.new(@raw)]
      end
    end

    def multiple?
      !!regex.match(@raw)
    end

    def regex
      /\s(?:and|&)\s/i
    end
  end
end
