require "ast"

module TrackParser
  class Processor < AST::Processor

    def on_track(node)
      process_all(node).reduce({}) { |mem, h| mem.merge(h) }
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
      { remixer: hash[:artist], remix_name: hash[:name] }
    end
  end
end
