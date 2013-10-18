require 'acceptance_helper'

feature "Home page" do

  scenario "Visit home page" do
    visit '/'
    page.should have_content 'Hello World!'
  end
end
