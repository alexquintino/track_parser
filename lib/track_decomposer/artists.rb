module TrackDecomposer

  class Artists
    def initialize(artists_part)
      @raw = artists_part
    end

    def to_a
      artists.map(&:strip)
    end

    private

    def multiple_artists?
      @raw.include?("&")
    end
    
    def artists
      if multiple_artists?
        /(.*)&+(.*)/.match(@raw).captures
      else
        [@raw]
      end
    end
    
  end

end