require_relative 'base_node'

module TrackParser
  class NameNode < BaseNode

    def initialize(name)
      super(:name, name)
    end

    def name
      @raw.strip
    end
  end
end
