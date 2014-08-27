require_relative "remix"

module TrackDecomposer
  class Track

    def initialize(track)
      @raw = track
    end

    def decomposable?
      @raw.include?("-")
    end

    def artists
      data[:artists]
    end

    def trackname
      data[:name]
    end

    def remix
      data[:remix]
    end

    def to_s
      @raw
    end

    def has_remix?
      parts.size == 3 || !!/\(.*(#{Remix::VERSIONS_REGEXP})+\)/.match(parts[1])
    end

    private

    def parts
      @parts ||= @raw.split("-").map(&:strip)
    end

    def data
      @data ||=
        if parts.size == 2
          if has_remix?
            { artists: parts[0], name: trackname_parts[:name].strip, remix: trackname_parts[:remix].strip }
          else
            { artists: parts[0], name: parts[1] }
          end
        else
          { artists: parts[0], name: parts[1], remix: parts[2] }
        end
    end

    def trackname_parts
      @trackname_parts ||= /(?<name>.*)\((?<remix>.+)\)/.match(parts[1])
    end
  end
end