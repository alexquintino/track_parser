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

        @artists = decompose_artists(parts[0].strip)
        @name, @remixer = decompose_trackname(parts[1].strip)
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@raw}")
      end
      self
    end

    def decompose_artists(artist_part)
      [artist_part]
    end

    def decompose_trackname(trackname_part)
      if /\(.+\)/.match trackname_part
        match = /(?<name>.*)\((?<remix>.+)\)/.match(trackname_part)
        name = match[:name].strip
        remixer = decompose_remix(match[:remix])
        return name, remixer
      else
        trackname_part.strip
      end
    end

    def decompose_remix(remix_part)
      remixer = /(?<remixer>.+)\b(remix|mix)/i.match(remix_part)[:remixer]
      remixer.strip
    end
  end

  class UndecomposableTrack < StandardError; end 
end