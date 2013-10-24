module Metrics
  module Aggregations
    class Sum

      def aggregate(events, field)
        map = %Q{
          function() {
            var formattedTime = this.time.getFullYear() + "-" + this.time.getMonth() + "-" + this.time.getDate();
            emit(formattedTime, { sum: this.%d });
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
        aggregated_data.map { |element| {DateTime.parse(element['_id']) => element['value'].values.first} }.sort_by{ |element| element.keys.first }
      end

    end
  end
end
