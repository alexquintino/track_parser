require_relative "nodes/remix_node"

module TrackParser
  class RemixFilter

    def self.filter(data)
      self.new(data).filter
    end

    def initialize(data)
      @data = data
    end

    def filter
      if has_remix?
        extracted = parentheses_content.select {|match| !remix_expr.match(match).nil?}.first #select first that matches a remix
        @data.add_section(:remix, extracted)
        @data.remove_text "(#{extracted})" #remove remix string from
      end
      return @data
    end

    def has_remix?
      !!/\(.*(#{RemixNode::VERSIONS_REGEXP})+\)/i.match(@data.text) #find remix keywords
    end

    def parentheses_content
      @data.text.scan(/\((?<content>.*?)\)/).flatten
    end

    def remix_expr
      /(?<remix>.*?\b(#{RemixNode::VERSIONS_REGEXP})+)\b/i
    end

  end
end
