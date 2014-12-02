require_relative 'base_node'
require_relative 'name_node'
require_relative 'remix_node'
require_relative 'featuring_node'
require_relative '../filter_pipeline'
require_relative '../filter_nodes_mapping'

module TrackParser
  class TracknameNode < BaseNode

    def initialize(trackname)
      super(:trackname, trackname)
    end

    def children
      sections, remaining_text = FilterPipeline.filter(@raw)
      [NameNode.new(remaining_text)] + FilterNodesMapping.to_nodes(sections)
    end
  end
end
