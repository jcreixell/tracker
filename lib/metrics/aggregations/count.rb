module Metrics
  module Aggregations
    class Count

      def aggregate(events)
        map = %Q{
          function() {
            var formattedTime = this.time.getFullYear() + "-" + this.time.getMonth() + "-" + this.time.getDate();
            emit(formattedTime, { count: 1 });
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
        aggregated_data.map { |element| {DateTime.parse(element['_id']) => element['value'].values.first} }.sort_by{ |element| element.keys.first }
      end

    end
  end
end
