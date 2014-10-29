require_relative "nodes/track_node"
require_relative "processor"

module TrackParser
  class Parser

    def self.do(track)
      self.new(track).parse
    end

    def initialize(track)
      @track = TrackNode.new(track)
    end

    def parse
      Processor.new.process(@track)
    end
  end
end
