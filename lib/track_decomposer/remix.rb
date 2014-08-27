module TrackDecomposer

  class Remix

    VERSIONS = ["remix", "mix", "vocal", "dub"]
    VERSIONS_REGEXP = VERSIONS.join("|")

    def initialize(remix_part)
      @raw = remix_part
      if !@raw.nil?
        @raw.gsub!(/(\(|\))/, "")
      end
    end

    def remixer
      parts[:remixer].strip unless @raw.nil?
    end

    def remix_name
      parts[:remix_name].strip unless @raw.nil?
    end

    private 

    def has_remix_name?
      @raw.include?("'s")
    end

    def parts
      @parts ||=
        if has_remix_name?
          parts = @raw.split("'s")
          {remixer: parts[0], remix_name: decompose_remix_name(parts[1])}
        else
          /(?<remixer>.+)\b(#{VERSIONS_REGEXP})/i.match(@raw)
        end
    end

    def decompose_remix_name(remix_name_part)
        /(?<remix_name>.+)\b(#{VERSIONS_REGEXP})/i.match(remix_name_part)[:remix_name]
    end
  
  end
end