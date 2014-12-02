require_relative "../nodes/remix_node"

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
        extracted = content.select {|match| !regexp.match(match).nil?}.first #select first that matches a remix
        @data.add_part(:remix, extracted)
        @data.remove_text "(#{extracted})" #remove remix string from
      end
      return @data
    end

    def has_remix?
      !!regexp #find remix keywords
    end

    def content
      text = @data.text
      if text =~ /(\(|\))+/
        text.scan(/\((?<content>.*?)\)/).flatten
      else
        [text]
      end
    end

    def regexp
      /(?<remix>.*?\b(#{RemixNode::VERSIONS_REGEXP})+)\b/i
    end

  end
end
