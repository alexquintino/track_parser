require 'bundler/setup'
Bundler.setup

require 'track_parser'

RSpec.configure do |config|

  config.order = :random

  Kernel.srand config.seed
end
