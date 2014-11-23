require_relative 'base_node'
require_relative 'artists_node'
require_relative 'name_node'

module TrackParser
  class RemixNode < BaseNode

    VERSIONS_REGEXP = ["remix", "mix", "vocal", "dub", "rework", "edit", "version", "extended", "club", "original"].join("|")

    def initialize(remix)
      raw = remix.gsub(/(\(|\))/, "") # remove parantheses
      super(:remix, raw)
    end

    def children
      if has_remix_name?
        nodes = @raw.split(/(?:'|´)s/)
        [ArtistsNode.new(nodes[0]), NameNode.new(nodes[1])]
      else
        [ArtistsNode.new(remixer), NameNode.new(remix_version)]
      end
    end

    def has_remix_name?
      @raw.include?("'s") || @raw.include?("´s")
    end

    def remixer
      without_version.strip
    end

    def remix_version(remix = @raw)
      remix.scan(/(#{VERSIONS_REGEXP})\b/i).flatten.join(" ")
    end

    def without_version(part = @raw)
      part.gsub(remix_version, "")
    end
  end
end
