require 'acceptance_helper'
require 'uuidtools'

feature "Overview page" do

  let(:project) { FactoryGirl.create(:project) }

  scenario "Visit overview page for a project" do
    visit "/metrics/#{project.api_key}/overview"
    page.should have_content 'Sales'
  end
end
