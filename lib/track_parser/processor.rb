require "ast"
require_relative "track"

module TrackParser
  class Processor < AST::Processor

    def initialize
      @track = Track.new
    end

    def on_track(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      @track.add_artists(hash[:artists])
      @track
    end

    def on_trackname(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      @track.add_name(hash[:name])
      {}
    end

    def on_artists(node)
      artists = process_all(node)
      { artists: artists }
    end

    def on_artist(node)
      node.name
    end

    def on_name(node)
      { name: node.name }
    end

    def on_remix(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      @track.add_remixer(hash[:artists])
      @track.add_remix_name(hash[:name])
      {}
    end

    def on_featuring(node)
      artists = process_all(node).first
      @track.add_featuring(artists[:artists])
      {}
    end

    def on_empty(node)
      {}
    end
  end
end
