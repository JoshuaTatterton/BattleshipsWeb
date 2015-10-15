BattleShips Web
------

During my time at Makers we created a website where players could play battleships locally, using a battleships ruby gem for the game logic but I was not happy with it only being playable locally. During lab week I built an online PVP game of battleships. I built the logic for the game myself in ruby and created a more dynamic way for the games to play out using Javascript.

Please find the website on Heroku [here](https://gentle-journey-9691.herokuapp.com)

#### Skills Used

- I used ruby to create the logic for manipulating the game state.
- The server was created using Sinatra.
- I used Javascript to control when players can fire at the boards.
- PostgrSQL and Datamapper was used to create and manipulate the database used.

#### Skills Gained/ Improved

- I had to learn how to use convert into YAML because I needed to store the game state in the database so two computers could play the same game.
- I needed use interval functions in jQuery to make get requests to my own server to find changes in the game state, this was used to manage player's turns.

#### Technologies Used

- Production: Ruby, Sinatra, PostgreSQL, Datamapper, HTML, CSS, Javascript, JQuery
- Testing: Rspec, Capybara, Database Cleaner

#### How To Use

- First clone and run bundle to install all relevant gems.
- You will also need to create a database for test and development to be able to run tests and 

#### User Stories

To Save on typing I will assume you know the rules of battleships

```
As a Player
So playing feels more personal
I would like to set my username
```
```
As a Player
So I can play a game of battleships
I would like to be able to start a game against a person online
```
###### While Playing

```
As a Player
So I can play strategically
I would like to place different sized ships on the board
```
```
As a Player
So I can win
I would like to be able to fire at my opponents board
```
```
As a Player
To make the game competitive
My opponent should be able to fire also
```
```
As a Player
So the game is fair
Me and my opponent should alternate turns
```
```
As a Player
So I can strategize
I would like to be able to see where I have previously fired 
```
```
As a Player
So I can strategize
I would like to know when I have sunk an opponents ship
```
```
As a Player
So I know how close my opponent is to winning
I would like to see my ships and where my opponent has fired.
```
```
As a Player
So the game does not go on forever
I would like to be declared nautical combat master when I win
```
####### Bonus (Not completed)
```
As a Player
So I can stop the robot advancement
I would like to play against a computer player
```