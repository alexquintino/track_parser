require_relative "filters/remix_filter"
require_relative "filters/featuring_filter"
require_relative "filtered_parts"

module TrackParser
  class FilterPipeline

    FILTERS = [RemixFilter, FeaturingFilter] #order matters currently

    def self.filter(text)
      size_last_pass = 0
      filtered = nil
      loop do #make several passes until nothing new is found
        filtered = FILTERS.reduce(FilteredParts.new(text)) { |data, filter_class| filter_class.filter(data) }
        break if filtered.parts.size == size_last_pass
        size_last_pass = filtered.parts.size
      end
      return filtered.parts, filtered.text
    end
  end
end
