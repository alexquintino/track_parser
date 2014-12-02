module TrackParser
  class FilteredSections

    def initialize(text)
      @remaining = text
      @sections = []
    end

    def text
      @remaining
    end

    def add_section(type, text)
      @sections << {type: type, text: text}
    end

    def remove_text(text)
      @remaining = @remaining.gsub(text, "")
    end

    def sections
      @sections
    end
  end
end
