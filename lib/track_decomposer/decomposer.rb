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
        @artists = decompose_artists(@raw_track.artists)
        @name, @remixer = decompose_trackname(Trackname.new(@raw_track.trackname))
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@raw_track.to_s}")
      end
      self
    end

     private

    def decompose_artists(artists_part)
      [artists_part]
    end

    def decompose_trackname(trackname_part)
      if trackname_part.has_remix?
        return trackname_part.name, Remix.new(trackname_part.remix).remixer
      else
        trackname_part.name
      end
    end

  end

  class UndecomposableTrack < StandardError; end 
end