require_relative "remix_filter"
require_relative "featuring_filter"
require_relative "filtered_sections"

module TrackParser
  class FilterPipeline

    FILTERS = [RemixFilter, FeaturingFilter] #order matters currently

    def self.filter(text)
      size_last_pass = 0
      filtered = nil
      loop do #make several passes until nothing new is found
        filtered = FILTERS.reduce(FilteredSections.new(text)) { |data, filter_class| filter_class.filter(data) }
        break if filtered.sections.size == size_last_pass
        size_last_pass = filtered.sections.size
      end
      return filtered.sections, filtered.text
    end
  end
end
