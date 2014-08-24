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

    def separate_name_and_remix?
      @raw.include?("-")
    end

    def parts
      @parts ||=
        if separate_name_and_remix?
          parts = @raw.split("-").map(&:strip)
          {name: parts[0], remix: parts[1]}
        else
          if has_remix?
            /(?<name>.*)\((?<remix>.+)\)/.match(@raw)
          else
            { name: @raw }
          end
        end
    end

 end

end