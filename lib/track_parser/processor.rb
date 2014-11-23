require "ast"

module TrackParser
  class Processor < AST::Processor

    def on_track(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      hash
    end

    def on_trackname(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      hash[:track_name] = hash[:name]
      hash.delete(:name)
      hash
    end

    def on_artists(node)
      artists = process_all(node)
      { artists: artists.map {|hash| hash[:artist]} }
    end

    def on_artist(node)
      { artist: node.name }
    end

    def on_name(node)
      { name: node.name }
    end

    def on_remix(node)
      hash = process_all(node).reduce({}) { |mem, h| mem.merge(h) }
      { remixer: hash[:artists], remix_name: hash[:name] }
    end

    def on_featuring(node)
      artists = process_all(node).first
      { featuring: artists[:artists] }
    end

    def on_empty(node)
      {}
    end
  end
end
