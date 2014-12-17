require_relative 'base_node'
require_relative 'artists_node'
require_relative 'trackname_node'
require_relative 'remix_node'

module TrackParser
  class TrackNode < BaseNode

    def initialize(track)
      raw = replace_parentheses(track)
      super(:track, raw)
    end

    def children
      if track_sections.size == 1
        raise UnparseableTrack.new("Don't know how to parse a track without \"-\". Track was:#{@raw}")
      else
        nodes = track_sections[2..-1].map do |track_section|
          parts = FilterPipeline.filter(track_section).first
          FilterNodesMapping.to_nodes(parts)
        end
        [ArtistsNode.new(track_sections[0]), TracknameNode.new(track_sections[1])] + nodes.flatten
      end
    end

    def replace_parentheses(text)
      if text.is_a? String
        text.gsub("[","(").gsub("]",")")
      else
        text[:name] = replace_parentheses(text[:name])
        text
      end
    end

    def track_sections
      if @raw.is_a? String
        split_sections(@raw)
      else
        [@raw[:artists]] + split_sections(@raw[:name])
      end
    end

    def split_sections(text)
      text.split(" - ").map(&:strip)
    end
  end

  class UnparseableTrack < StandardError; end
end
