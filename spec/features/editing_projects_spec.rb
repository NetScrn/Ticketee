require "rails_helper"

RSpec.feature "Users can edit existing projects" do
  before do
    FactoryGirl.create(:project, name: "Sublime Text 3")
    visit "/"

    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "with valid attributes" do
    fill_in "Name",         with: "Atom"
    fill_in "Description",  with: "Better than Sublime Text 3"

    click_button "Update Project"

    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "Atom"
    expect(page).to have_content "Better than Sublime Text 3"
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""

    click_button "Update Project"

    expect(page).to have_content "Project has not been updated."
    expect(page).to have_content "Name can't be blank"
  end
end
