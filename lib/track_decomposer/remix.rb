module TrackDecomposer

  class Remix

    def initialize(remix_part)
      @raw = remix_part
    end

    def has_remix_name?
      @raw.include?("'s")
    end

    def remixer
      parts[:remixer].strip
    end

    def remix_name
      parts[:remix_name].strip
    end

    def parts
      @parts ||=
        if has_remix_name?
          parts = @raw.split("'s")
          {remixer: parts[0], remix_name: decompose_remix_name(parts[1])}
        else
          /(?<remixer>.+)\b(remix|mix)/i.match(@raw)
        end
    end

    def decompose_remix_name(remix_name_part)
        /(?<remix_name>.+)\b(remix|mix)/i.match(@raw)[:remix_name]
    end
    
  end
end