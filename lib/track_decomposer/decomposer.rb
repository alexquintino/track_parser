module TrackDecomposer
  class Decomposer

    attr_reader :artists, :name, :remixer

    def self.do(track)
      self.new(track).decompose
    end

    def initialize(track)
      @raw_track = RawTrack.new(track)
    end

    def decompose
      if @raw_track.valid?
        @artists = Artists.new(@raw_track.artists).artists
        @name = @raw_track.trackname
        @remixer = Remix.new(@raw_track.remix).remixer
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@raw_track.to_s}")
      end
      self
    end

  end

  class UndecomposableTrack < StandardError; end 
end