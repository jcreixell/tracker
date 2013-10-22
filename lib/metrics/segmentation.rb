require_relative 'aggregations/count'

module Metrics
  class Segmentation

    def initialize(name, project, event_type, start_time, end_time, properties={})
      @name = name
      @project = project
      @event_type = event_type
      @start_time = start_time
      @end_time = end_time
      @properties = properties
    end

    def process(format=:json)
      events = @project.events.where(:type => @event_type, :time => @start_time..@end_time)
      result = ::Metrics::Aggregations::Count.new.aggregate(events)

      case format
      when :json
        format_json(result)
      else
        raise ::Metrics::UnsupportedFormat
      end
    end

    private

    def format_json(result)
      JSON.dump({
        'name' => @name,
        'pointInterval' => 1.day * 1000,
        'pointStart' => result.first.keys.first.to_i * 1000,
        'data' => result.map { |element| element.values.first }
      })
    end

  end
end   
