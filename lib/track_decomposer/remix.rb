module TrackDecomposer

  class Remix

    def initialize(remix_part)
      @raw = remix_part
    end

    def remixer
      /(?<remixer>.+)\b(remix|mix)/i.match(@raw)[:remixer].strip
    end
    
  end
end