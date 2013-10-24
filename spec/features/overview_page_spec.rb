require 'acceptance_helper'

feature "Overview page" do

  let(:project) { FactoryGirl.create(:project) }

  scenario "Visit overview page for a project" do
    visit "/metrics/#{project.api_key}/overview?startDate=2013-01-01&endDate=2014-01-01"
    page.should have_content 'Sales'
  end
end
