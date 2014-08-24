module TrackDecomposer
  class RawTrack

    def initialize(track)
      @raw = track
    end

    def valid?
      has_artist_and_trackname?
    end

    def has_artist_and_trackname?
      @raw.include?("-")
    end

    def artists
      track_parts[0]
    end

    def trackname
      track_parts[1..-1].reduce(:+)
    end

    def track_parts
      @parts ||= @raw.split("-").map(&:strip)
    end

    def to_s
      @raw
    end
  end
end