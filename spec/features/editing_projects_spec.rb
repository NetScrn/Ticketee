require "rails_helper"

RSpec.feature "Project managers can edit existing projects" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, name: "Sublime Text 3") }

  before do
    login_as(user)
    assign_role!(user, :manager, project)
    visit "/"

    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Atom"

    click_button "Update Project"

    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "Atom"
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""

    click_button "Update Project"

    expect(page).to have_content "Project has not been updated."
    expect(page).to have_content "Name can't be blank"
  end
end
