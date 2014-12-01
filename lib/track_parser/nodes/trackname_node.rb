require_relative 'base_node'
require_relative 'name_node'
require_relative 'remix_node'
require_relative 'featuring_node'
require_relative '../remix_filter'

module TrackParser
  class TracknameNode < BaseNode

    def initialize(trackname)
      super(:trackname, trackname)
    end

    def children
      remix_text, remaining_text = RemixFilter.filter(@raw) #start by extracting the remix part
      featuring_node, remaining_text = extract_featuring_node(remaining_text) #continue by extracting the featured part
      [NameNode.new(remaining_text), RemixNode.new(remix_text), featuring_node].compact
    end

    def has_featuring?
      !!/\W(#{FeaturingNode::VERSIONS_REGEXP})\W/i.match(@raw)
    end

    def featuring_expr
      /(?<featuring>\(?(#{FeaturingNode::VERSIONS_REGEXP})\s.*\)?)/i #find featuring keywords
    end

    def extract_featuring_node(text)
      if has_featuring?
        featuring_text = featuring_expr.match(text)[:featuring]
        node = FeaturingNode.new(featuring_text)
        remaining = text.gsub(featuring_text, "").gsub("(","").gsub(")","") #remove featuring artists from trackname plus any lingering parentheses
        return node, remaining
      else
        return nil, text
      end
    end

    def parentheses_content(text)
      text.scan(/\((?<content>.*?)\)/).flatten
    end

  end
end
