require 'acceptance_helper'
require 'uuidtools'

feature "Overview page" do

  let(:project) { Project.create!(name: 'test', api_key: UUIDTools::UUID.timestamp_create.to_s) }

  background do
    Project.delete_all
  end

  scenario "Visit overview page for a project" do
    visit "/metrics/#{project.api_key}/overview"
    page.should have_content 'Sales'
  end
end
