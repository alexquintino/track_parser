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
        featuring_text = featuring_expr.match(@data.text)[:featuring]
        @data.add_part(:featuring, featuring_text)
        @data.remove_text(featuring_text) #remove featuring artists from trackname
      end
      return @data
    end

    def has_featuring?
      !!/\W(#{FeaturingNode::VERSIONS_REGEXP})\W/i.match(@data.text)
    end

    def featuring_expr
      /(?<featuring>\(?(#{FeaturingNode::VERSIONS_REGEXP})\s.*\)?)/i #find featuring keywords
    end

    def parentheses_content(text)
      text.scan(/\((?<content>.*?)\)/).flatten
    end
  end
end
