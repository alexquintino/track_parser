require_relative 'base_node'
require_relative 'name_node'
require_relative 'remix_node'
require_relative 'featuring_node'

module TrackParser
  class TracknameNode < BaseNode

    def initialize(trackname)
      super(:trackname, trackname)
    end

    def children
      remix_node, remaining_text = extract_remix_node(@raw) #start by extracting the remix part
      featuring_node, remaining_text = extract_featuring_node(remaining_text) #continue by extracting the featured part
      [NameNode.new(remaining_text), remix_node, featuring_node].compact
    end

    def has_remix?
      !!/\(.*(#{RemixNode::VERSIONS_REGEXP})+\)/i.match(@raw) #find remix keywords
    end

    def has_featuring?
      !!/\W(#{FeaturingNode::VERSIONS_REGEXP})\W/i.match(@raw)
    end

    def remix_expr
      /(?<remix>.*?\b(#{RemixNode::VERSIONS_REGEXP})+)\b/i
    end

    def featuring_expr
      /(?<featuring>\(?(#{FeaturingNode::VERSIONS_REGEXP})\s.*\)?)/i #find featuring keywords
    end

    def extract_remix_node(text)
      if has_remix?
        remix_string = parentheses_content(text).select {|match| !remix_expr.match(match).nil?}.first #select first that matches a remix
        node = RemixNode.new(remix_string)
        remaining = text.gsub("(#{remix_string})", "") #remove remix string from trackname
        return node, remaining
      else
        return nil, text
      end
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
