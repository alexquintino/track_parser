require 'ast'

class EmptyNode < AST::Node
  def initialize
    super(:empty, [])
  end
end
