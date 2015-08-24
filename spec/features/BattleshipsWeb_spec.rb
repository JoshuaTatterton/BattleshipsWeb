require "spec_helper"

feature "BattleshipsWeb" do
  context "Setting up a game" do
    scenario "I am welcomed to the website" do 
      visit "/"
      expect(page.status_code).to eq 200
      expect(page).to have_content "Welcome to the Battleship playing capital of this website."
    end
    scenario "I can choose my username" do
      visit "/"
      expect(page).to have_content "Please select a username"
      eg_name = "Monkey D. Luffy"
      fill_in "name", with: eg_name
      click_button "Continue"
      expect(page).to have_content "Welcome #{eg_name}"
      expect(page).to have_content "Select game mode"
    end
    scenario "I am given a default name if no username submitted" do
      visit "/"
      click_button "Continue"
      expect(page).to have_content "Welcome Player"
    end
    scenario "I can choose to play against a human opponent" do
      visit "/"
      click_button "Continue"
      click_link "Online PVP"
      expect(page.status_code).to eq 200
    end
  end
end