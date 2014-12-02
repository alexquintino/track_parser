require_relative '../nodes/remix_node'
require_relative '../nodes/featuring_node'

module TrackParser
  class FilterNodesMapping
    FILTERS_NODES_MAPPING = {remix: RemixNode, featuring: FeaturingNode}

    def self.to_nodes(parts)
      parts.map { |part| FILTERS_NODES_MAPPING[part[:type]].new(part[:text])}
    end
  end
end
