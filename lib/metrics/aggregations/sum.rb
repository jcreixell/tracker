module Metrics
  module Aggregations
    class Sum

      def aggregate(events, field)
        map = %Q{
          function() {
            var day = Date.UTC(this.time.getFullYear(),this.time.getMonth(),this.time.getDate());
            emit(day, { sum: this.properties.%s });
          }
        } % field

        reduce = %Q{
          function(key, values) {
            var result = { sum: 0 };
            values.forEach(function(value) {
              result.sum += value.sum;
            });
            return result;
          }
        }

        aggregated_data = events.map_reduce(map, reduce).out(inline: true)
        aggregated_data.map { |element| {Time.at(element['_id'] / 1000).utc.to_datetime => element['value'].values.first} }.sort_by{ |element| element.keys.first }
      end

    end
  end
end
