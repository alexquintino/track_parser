module TrackParser
  class FeaturingFilter

    def self.filter(text)
      self.new(text).filter
    end

    def initialize(text)
      @text = text
    end

    def filter
      if has_featuring?
        featuring_text = featuring_expr.match(@text)[:featuring]
        remaining = @text.gsub(featuring_text, "").gsub("(","").gsub(")","") #remove featuring artists from trackname plus any lingering parentheses
        return featuring_text, remaining
      else
        return nil, @text
      end
    end

    def has_featuring?
      !!/\W(#{FeaturingNode::VERSIONS_REGEXP})\W/i.match(@text)
    end

    def featuring_expr
      /(?<featuring>\(?(#{FeaturingNode::VERSIONS_REGEXP})\s.*\)?)/i #find featuring keywords
    end

    def parentheses_content(text)
      text.scan(/\((?<content>.*?)\)/).flatten
    end
  end
end
