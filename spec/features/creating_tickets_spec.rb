require "rails_helper"

RSpec.feature "Users can create new tickets" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    assign_role!(user, :editor, project)

    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "With valid attributes" do
    fill_in "Name",        with: "Non-standards compliance"
    fill_in "Description", with: "My page are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within("#ticket") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "With invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "With an invalid description" do
    fill_in "Name",        with: "Non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

  scenario "With an attachment" do
    fill_in "Name",        with: "Add documentation for the blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "persisting file uploads across form displays" do
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    fill_in "Name",        with: "Add documentation for blink taf"
    fill_in "Description", with: "The blink tag has a speed attribute"
    click_button "Create Ticket"

    within("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "with multiple attachments" do
    fill_in "Name",        with: "Add documentation for blick tag"
    fill_in "Description", with: "The blink tah das a speed attribute"

    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
    attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "spin.txt"
      expect(page).to have_content "gradient.txt"
    end
  end
end
