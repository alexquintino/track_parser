require_relative 'nodes/remix_node'
require_relative 'nodes/featuring_node'

module TrackParser
  class FilterNodesMapping
    FILTERS_NODES_MAPPING = {remix: RemixNode, featuring: FeaturingNode}

    def self.to_nodes(sections)
      sections.map { |section| FILTERS_NODES_MAPPING[section[:type]].new(section[:text])}
    end
  end
end
