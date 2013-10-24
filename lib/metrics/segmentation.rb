require_relative 'aggregations/count'

module Metrics
  class Segmentation

    def initialize(project, event_type, start_time, end_time, properties={})
      @project = project
      @event_type = event_type
      @start_time = start_time
      @end_time = end_time
      @properties = properties
    end

    def process
      events = @project.events.where(:type => @event_type, :time => @start_time..@end_time)
      ::Metrics::Aggregations::Count.new.aggregate(events)
    end

  end
end   
