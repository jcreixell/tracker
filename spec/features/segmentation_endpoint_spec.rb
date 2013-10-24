require 'acceptance_helper'

feature "Overview page" do

  let(:project) { FactoryGirl.create(:project) }

  background do
    3.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 2, 12, i + 1)) }
    2.times { |i| project.events.create(type: "sale", time: DateTime.new(2013, 1, 1, 12, i + 1)) }
  end

  scenario "Request segmentation data for a project" do
    p Event.all.to_s
    get "/metrics/#{project.api_key}/data/segmentation?callback=callback?&startDate=2013-01-01&endDate=2014-01-01"

    expect(last_response).to be_successful
    last_response.header['Content-Type'].should include 'application/javascript'
    last_response.body.should == %Q{callback?({"element":"sales","xkey":"key","ykeys":["value"],"labels":["time"],"data":[{"key":"2013-01-01T00:00:00+00:00","value":2},{"key":"2013-01-02T00:00:00+00:00","value":3}]})}
  end
end
