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
    scenario "My username is stored in the database" do
      visit "/"
      eg_name = "Monkey D. Luffy"
      fill_in "name", with: eg_name
      expect { click_button "Continue" }.to change(Player, :count).by 1
    end
    scenario "I can choose to play against a human opponent" do
      visit "/"
      click_button "Continue"
      click_link "Online PVP"
      expect(page.status_code).to eq 200
    end
    context "as player 1" do
      scenario "I can join" do
        name = "Zoro"
        start_pvp_game(name)
        expect(page).to have_content "Welcome #{name}, please place your ships while we wait for a second player"
      end
      scenario "It creates a new game and saves it to the database" do 
        name = "Zoro"
        expect { start_pvp_game(name) }.to change(Game, :count).by 1
      end
      scenario "player knows the game they are playing and vice versa" do 
        name = "Zoro"
        start_pvp_game(name)
        player = Player.first(name: name)
        game = Game.last_game
        expect(player.id).to eq game.player1
        expect(player.game_id).to eq game.id
      end
    end
    context "as player 2" do
      scenario "I can join" do
        name1 = "Nami"
        name2 = "Robin"
        start_pvp_game(name1)
        start_pvp_game(name2)
        expect(page).to have_content "We've been waiting for you #{name2}, #{name1} has been waiting for you"
        expect(page).to have_content "Please place your ships to begin"
      end
      scenario "It doesn't create a new game" do 
        name1 = "Nami"
        name2 = "Robin"
        start_pvp_game(name1)
        expect { start_pvp_game(name2) }.not_to change(Game, :count)
      end
      scenario "player knows the game they are playing and vice versa" do 
        name1 = "Nami"
        name2 = "Robin"
        start_pvp_game(name1)
        start_pvp_game(name2)
        player = Player.first(name: name2)
        game = Game.last_game
        expect(player.id).to eq game.player2
        expect(player.game_id).to eq game.id
      end
    end
    context "players can place ships" do
      scenario "Player1" do
        name = "Franky"
        start_pvp_game(name)
        click_link "Place Ships"
        expect(page).to have_content "#{name} where do you want to place your ships"
        expect(page).to have_content "Aircraft Carrier(5):"
        placeh "A1"
        expect(page).to have_content "Battleship(4)"
      end
    end
  end
end
def start_pvp_game(name = "")
  visit "/"
  fill_in "name", with: name
  click_button "Continue"
  click_link "Online PVP"
end
def placev coord
  fill_in "location", with: coord
  select "vertical", :from => "direction"
  click_button 'Place'
end
def placeh coord
  fill_in "location", with: coord
  select "horizontal", :from => "direction"
  click_button 'Place'
end