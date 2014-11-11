require 'ast'
require_relative 'artist_node'
require_relative 'name_node'

module TrackParser
  class RemixNode < AST::Node

    VERSIONS_REGEXP = ["remix", "mix", "vocal", "dub", "rework", "edit"].join("|")

    def initialize(remix)
      raw = remix.gsub(/(\(|\))/, "") # remove parantheses
      super(:remix, [], {raw: raw})
    end

    def children
      if original_mix?
        [NameNode.new(@raw)]
      else
        if has_remix_name?
          nodes = @raw.split("'s")
          [ArtistsNode.new(nodes[0]), NameNode.new(remix_name(nodes[1]))]
        else
          [ArtistsNode.new(remixer), NameNode.new(remix_version)]
        end
      end
    end

    def has_remix_name?
      @raw.include?("'s")
    end

    def remixer(remix = @raw)
      /(?<remixer>.+)\b(#{VERSIONS_REGEXP})/i.match(remix)[:remixer]
    end

    def remix_name(name_part)
      /(?<remix_name>.+\b(#{VERSIONS_REGEXP}))/i.match(name_part)[:remix_name].strip
    end

    def remix_version(remix = @raw)
      remix.scan(/(#{VERSIONS_REGEXP})\b/i).flatten.join(" ")
    end

    def original_mix?(remix = @raw)
      remixer.downcase.strip == 'original'
    end
  end
end
