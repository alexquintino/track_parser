module TrackDecomposer
  class Decomposer

    attr_reader :artists, :name, :remixer

    def self.do(track)
      self.new(track).decompose
    end

    def initialize(track)
      @raw = RawTrack.new(track)
    end

    def decompose
      if @raw.has_artist_and_trackname?
        artists_part, trackname_part  = @raw.split_artists_and_trackname

        @artists = decompose_artists(artists_part)
        @name, @remixer = decompose_trackname(Trackname.new(trackname_part))
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@raw}")
      end
      self
    end

     private

    def decompose_artists(artist_part)
      [artist_part]
    end

    def decompose_trackname(trackname_part)
      if trackname_part.has_remix?
        name, remix_part = trackname_part.split_trackname_and_remix
        remixer = decompose_remix(remix_part)
        return name, remixer
      else
        trackname_part.to_s
      end
    end

    def decompose_remix(remix_part)
      remixer = /(?<remixer>.+)\b(remix|mix)/i.match(remix_part)[:remixer]
      remixer.strip
    end
  end

  class UndecomposableTrack < StandardError; end 
end