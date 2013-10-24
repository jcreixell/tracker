module Metrics
  module Aggregations
    class Count

      def aggregate(events)
        map = %Q{
          function() {
            var day = Date.UTC(this.time.getFullYear(),this.time.getMonth(),this.time.getDate());
            emit(day, { count: 1 });
          }
        }

        reduce = %Q{
          function(key, values) {
            var result = { count: 0 };
            values.forEach(function(value) {
              result.count += value.count;
            });
            return result;
          }
        }

        aggregated_data = events.map_reduce(map, reduce).out(inline: true)
        aggregated_data.map { |element| {Time.at(element['_id'] / 1000).utc.to_datetime => element['value'].values.first.to_i} }.sort_by{ |element| element.keys.first }
      end

    end
  end
end
