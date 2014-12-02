module TrackParser
  class FilteredParts

    def initialize(text)
      @remaining = text
      @parts = []
    end

    def text
      @remaining
    end

    def add_part(type, text)
      @parts << {type: type, text: text}
    end

    def remove_text(text)
      @remaining = @remaining.gsub(text, "")
    end

    def parts
      @parts
    end
  end
end
