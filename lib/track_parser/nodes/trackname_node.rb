require_relative 'base_node'
require_relative 'name_node'
require_relative 'remix_node'
require_relative 'featuring_node'
require_relative '../remix_filter'
require_relative '../featuring_filter'

module TrackParser
  class TracknameNode < BaseNode

    def initialize(trackname)
      super(:trackname, trackname)
    end

    def children
      remix_text, remaining_text = RemixFilter.filter(@raw) #start by extracting the remix part
      featuring_text, remaining_text = FeaturingFilter.filter(remaining_text) #continue by extracting the featured part
      [NameNode.new(remaining_text), RemixNode.new(remix_text), FeaturingNode.new(featuring_text)]
    end
  end
end
