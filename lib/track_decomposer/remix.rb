module TrackDecomposer

  class Remix

    VERSIONS = ["remix", "mix", "vocal", "dub"]
    VERSIONS_REGEXP = VERSIONS.join("|")

    def initialize(remix_part)
      @raw = remix_part.gsub(/(\(|\))/, "")
    end

    def remixer
      data[:remixer]
    end

    def remix_name
      data[:remix_name]
    end

    private 

    def has_remix_name?
      @raw.include?("'s")
    end

    def data
      @data ||=
        if has_remix_name?
          parts = @raw.split("'s")
          {remixer: parts[0], remix_name: decompose_remix_name(parts[1])}
        else
          match = /(?<remixer>.+)\b(#{VERSIONS_REGEXP})/i.match(@raw)
          {remixer: match[:remixer].strip, remix_name: nil}
        end
    end

    def decompose_remix_name(remix_name_part)
        /(?<remix_name>.+\b(#{VERSIONS_REGEXP}))/i.match(remix_name_part)[:remix_name].strip
    end
  end

  NullRemix = Struct.new(:remixer, :remix_name).new(nil,nil)
end