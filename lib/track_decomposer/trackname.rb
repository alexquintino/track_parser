module TrackDecomposer

  class Trackname

    def initialize(name_part)
      @raw = name_part      
    end

    def has_remix?
      !!/\(.+\)/.match(@raw)
    end

    def split_trackname_and_remix
      match = /(?<name>.*)\((?<remix>.+)\)/.match(@raw)
      return match[:name].strip, match[:remix].strip
    end

    def to_s
      @raw
    end

  end

end