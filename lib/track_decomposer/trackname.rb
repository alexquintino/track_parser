module TrackDecomposer

  class Trackname

    def initialize(trackname_part)
      @raw = trackname_part      
    end

    def has_remix?
      !!/\(.+\)/.match(@raw)
    end

    def name
      parts[:name].strip
    end

    def remix
      parts[:remix].strip
    end

    def parts
      if has_remix?
        @parts ||= /(?<name>.*)\((?<remix>.+)\)/.match(@raw)
      else
        @parts ||= { name: @raw }
      end
    end

 end

end