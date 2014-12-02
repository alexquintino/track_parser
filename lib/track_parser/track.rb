module TrackParser
  class Track

    attr_accessor :artists, :name, :remixer, :remix_name, :featuring

    def initialize(hash = {})
      @artists = hash[:artists]
      @name = hash[:name]
      @remixer = hash[:remixer]
      @remix_name = hash[:remix_name]
      @featuring = hash[:featuring]
    end

    def add_artists(artists)
      @artists = artists
    end

    def add_remixer(remixer)
      @remixer = remixer unless remixer.nil?
    end

    def add_remix_name(remix_name)
      return if remix_name.nil?
      if @remix_name.nil?
        @remix_name = remix_name
      else
        @remix_name += " " + remix_name
      end
    end

    def add_name(name)
      @name = name
    end

    def add_featuring(featured_artists)
      @featuring = featured_artists
    end

  end
end
