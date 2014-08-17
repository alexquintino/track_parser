require 'bundler/setup'
Bundler.setup

require 'track_decomposer'

RSpec.configure do |config|

  config.order = :random

  Kernel.srand config.seed
end
