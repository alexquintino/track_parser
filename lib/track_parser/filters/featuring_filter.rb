module TrackParser
  class FeaturingFilter

    def self.filter(data)
      self.new(data).filter
    end

    def initialize(data)
      @data = data
    end

    def filter
      if has_featuring?
        featuring_text = regexp.match(@data.text)[:featuring]
        @data.add_part(:featuring, featuring_text)
        @data.remove_text(featuring_text) #remove featuring artists from trackname
      end
      return @data
    end

    def has_featuring?
      !!regexp.match(@data.text)
    end

    def regexp
      /(?<featuring>\(?(#{FeaturingNode::VERSIONS_REGEXP})\s.*\)?)/i #find featuring keywords
    end

  end
end
