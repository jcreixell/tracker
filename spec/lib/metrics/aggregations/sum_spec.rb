require 'spec_helper'

module Metrics
  module Aggregations
    describe Sum do
      describe "aggregate" do
        let(:project) { FactoryGirl.create(:project) }

        it "aggregates the events by day using sum" do
          3.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 2, 12, i + 1), properties: { amount: 50 }) }
          2.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 1, 12, i + 1), properties: { amount: 20 }) }

          aggregated_data = ::Metrics::Aggregations::Sum.new.aggregate(project.events, 'amount')
          aggregated_data.should == [{DateTime.new(2013, 1, 1) => 40.0}, {DateTime.new(2013, 1, 2) => 150.0}]
        end

        it "sorts the results by date" do
          dates = [
            DateTime.new(2013, 1, 5),
            DateTime.new(2013, 12, 2),
            DateTime.new(2012, 1, 2),
            DateTime.new(2015, 4, 2)
          ]
          dates.each { |date| project.events.create(type: "sale", time: date, properties: { amount: 10 }) }

          aggregated_data = ::Metrics::Aggregations::Sum.new.aggregate(project.events, 'amount')
          aggregated_data.map { |elem| elem.keys.first }.should == dates.sort
        end

      end
    end
  end
end
