require 'spec_helper'

module Metrics
  module Aggregations
    describe Count do
      describe "aggregate" do
        let(:project) { FactoryGirl.create(:project) }

        it "aggregates the events by day using count" do
          3.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 2, 12, i + 1)) }
          2.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 1, 12, i + 1)) }

          aggregated_data = ::Metrics::Aggregations::Count.new.aggregate(project.events)
          aggregated_data.should == [{DateTime.new(2013, 1, 1) => 2}, {DateTime.new(2013, 1, 2) => 3}]
        end

        it "sorts the results by date" do
          dates = [
            DateTime.new(2013, 1, 5),
            DateTime.new(2013, 12, 2),
            DateTime.new(2012, 1, 2),
            DateTime.new(2015, 4, 2)
          ]
          dates.each { |date| project.events.create(type: "sale", time: date) }

          aggregated_data = ::Metrics::Aggregations::Count.new.aggregate(project.events)
          aggregated_data.map { |elem| elem.keys.first }.should == dates.sort
        end

      end
    end
  end
end
