module TrackDecomposer
  class Decomposer

    attr_reader :artists, :name, :remixer

    def initialize(track)
      @raw = track
    end

    def self.do(track)
      self.new(track).decompose
    end

    def decompose
      if @raw.include?("-")
        parts = @raw.split("-")

        @artists = decompose_artists(parts[0])
        @name, @remixer = decompose_trackname(parts[1])
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@raw}")
      end
      self
    end

    def decompose_artists(artist_part)
      [artist_part.strip]
    end

    def decompose_trackname(trackname_part)
      trackname_part.strip
    end
  end

  class UndecomposableTrack < StandardError; end 
end