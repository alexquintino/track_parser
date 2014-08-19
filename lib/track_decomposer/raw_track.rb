module TrackDecomposer
  class RawTrack

    def initialize(track)
      @raw = track
    end

    def has_artist_and_trackname?
      @raw.include?("-")
    end

    def split_artists_and_trackname
      parts = @raw.split("-")
      return parts[0].strip, parts[1].strip
    end

  end
end