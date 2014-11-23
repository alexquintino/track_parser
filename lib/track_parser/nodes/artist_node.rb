require_relative 'base_node'

module TrackParser
  class ArtistNode < BaseNode

    def initialize(raw)
      super(:artist, raw)
    end

    def name
      @raw.strip
    end
  end
end
