module TrackDecomposer

  class Artists
    def initialize(artists_part)
      @raw = artists_part
    end

    def multiple_artists?
      @raw.include?("&")
    end
    
    def artists
      if multiple_artists?
        /(.*)&+(.*)/.match(@raw).captures.map(&:strip)
      else
        [@raw]
      end
    end
    
  end

end