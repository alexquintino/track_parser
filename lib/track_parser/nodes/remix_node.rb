require 'ast'
require_relative 'artist_node'
require_relative 'name_node'

module TrackParser
  class RemixNode < AST::Node

    VERSIONS = ["remix", "mix", "vocal", "dub"]
    VERSIONS_REGEXP = VERSIONS.join("|")

    def initialize(remix)
      raw = remix.gsub(/(\(|\))/, "")
      super(:remix, [], {raw: raw})
    end

    def children
      if has_remix_name?
        nodes = @raw.split("'s")
        [ArtistNode.new(nodes[0]), NameNode.new(remix_name(nodes[1]))]
      else
        [ArtistNode.new(remixer)]
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
  end
end
