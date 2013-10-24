require 'spec_helper'

module Metrics
  describe Segmentation do
    describe "process" do
      let(:project) { FactoryGirl.create(:project) }

      it "filters events by date" do
        event_dates = [
          DateTime.new(2013, 1, 5),
          DateTime.new(2013, 12, 2),
          DateTime.new(2012, 1, 2),
          DateTime.new(2015, 4, 2)
        ]
        event_dates.each { |date| project.events.create(type: "sale", time: date, properties: { amount: 10 }) }

        result = Metrics::Segmentation.new(project, "sale", DateTime.new(2013, 1, 1), DateTime.new(2014, 1, 1)).process
        result_dates = result.map{ |elem| elem.keys.first }
        event_dates[0..1].each { |date| result_dates.should include date }
        event_dates[2..3].each { |date| result_dates.should_not include date }
      end

    end
  end
end
