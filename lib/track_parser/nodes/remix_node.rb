require 'ast'
require_relative 'artist_node'
require_relative 'name_node'

module TrackParser
  class RemixNode < AST::Node

    VERSIONS_REGEXP = ["remix", "mix", "vocal", "dub"].join("|")

    def initialize(remix)
      raw = remix.gsub(/(\(|\))/, "") # remove parantheses
      super(:remix, [], {raw: raw})
    end

    def children
      if original_mix?
        []
      else
        if has_remix_name?
          nodes = @raw.split("'s")
          [ArtistNode.new(nodes[0]), NameNode.new(remix_name(nodes[1]))]
        else
          [ArtistNode.new(remixer)]
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

    def original_mix?(remix = @raw)
      remixer.downcase.strip == 'original'
    end
  end
end
