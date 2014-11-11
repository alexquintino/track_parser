require 'ast'
require_relative 'artists_node'
require_relative 'trackname_node'
require_relative 'remix_node'

module TrackParser
  class TrackNode < AST::Node

    def initialize(track)
      raw = track.gsub("[","(").gsub("]",")")
      super(:track, [], {raw: track})
    end

    def children
      track_parts = @raw.split(" - ").map(&:strip)
      case track_parts.size
      when 1
        raise UnparseableTrack.new("Don't know how to parse a track without \"-\". Track was:#{@raw}")
      when 2
        [ArtistsNode.new(track_parts[0]), TracknameNode.new(track_parts[1])]
      when 3
        [ArtistsNode.new(track_parts[0]), TracknameNode.new(track_parts[1]), RemixNode.new(track_parts[2])]
      else
        [ArtistsNode.new(track_parts[0]), TracknameNode.new(track_parts[1]), RemixNode.new(track_parts[2..-1].join(" "))]
      end
    end
  end

  class UnparseableTrack < StandardError; end
end
