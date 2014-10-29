require "ast"

class ArtistNode < AST::Node

  def initialize(raw)
    super(:artist, [], {raw: raw})
  end

  def name
    @raw.strip
  end
end
