require_relative "nodes/remix_node"

module TrackParser
  class RemixFilter

    def self.filter(text)
      self.new(text).filter
    end

    def initialize(text)
      @text = text
    end

    def filter
      if has_remix?
        extracted = parentheses_content.select {|match| !remix_expr.match(match).nil?}.first #select first that matches a remix
        remaining = @text.gsub("(#{extracted})", "") #remove remix string from
        return extracted, remaining
      else
        return nil, @text
      end
    end

    def has_remix?
      !!/\(.*(#{RemixNode::VERSIONS_REGEXP})+\)/i.match(@text) #find remix keywords
    end

    def parentheses_content
      @text.scan(/\((?<content>.*?)\)/).flatten
    end

    def remix_expr
      /(?<remix>.*?\b(#{RemixNode::VERSIONS_REGEXP})+)\b/i
    end

  end
end
