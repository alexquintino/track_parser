require_relative 'base_node'
require_relative 'artists_node'
require_relative 'trackname_node'
require_relative 'remix_node'

module TrackParser
  class TrackNode < BaseNode

    def initialize(track)
      raw = track.gsub("[","(").gsub("]",")")
      super(:track, raw)
    end

    def children
      track_sections = @raw.split(" - ").map(&:strip)
      case track_sections.size
      when 1
        raise UnparseableTrack.new("Don't know how to parse a track without \"-\". Track was:#{@raw}")
      when 2
        [ArtistsNode.new(track_sections[0]), TracknameNode.new(track_sections[1])]
      else
        nodes = track_sections[2..-1].map do |track_section|
          parts = FilterPipeline.filter(track_section).first
          FilterNodesMapping.to_nodes(parts)
        end
        [ArtistsNode.new(track_sections[0]), TracknameNode.new(track_sections[1])] + nodes.flatten
      end
    end
  end

  class UnparseableTrack < StandardError; end
end
