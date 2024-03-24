## Scoring System

Scoring System for a Tennis match is implemented in the `Match` class. The scoring system is based on the rules of tennis, where points are scored in a game and games are scored in a set. The scoring system includes the following features:

- Struct to hold the player names and their scores.
- PointWonBy Method to score a point for a player.
- Score Method to return the current set score followed by the current game score.
- Game Score is described as 0, 15, 30, 40, Deuce, Advantage, Tie-Break, Winner, etc.
- Set Score is described as 0-0, 1-0, 0-1, etc.

### Technical Overview
```
ruby '3.2.2'
gem 'rspec'
```
- Using `rbenv` as the Ruby Version Manager.
- Using `git` version control.

### Implementation Overview
- `ScoringSystem::Tennis::Match` class is implemented to score a Tennis match, where points are scored in a game and games are scored in a set.
- The class has the following methods:
    - `initialize` method to initialize the player names and their scores
    - `point_won_by` method to score a point for a player
    - `score` method to return the current set score followed by the current game score
- Helper modules to refactor the code and keep it DRY.
- `Match` class is tested using Rspec. Tests are written to cover all possible scenarios:
  - `pointWonBy` an alias method name can be used to invoke the `point_won_by` method 
- `spec_helper.rb` file is used to configure Rspec and load the required files.

### Steps to setup and run the specs
- Clone the forked repository
```
  git clone git@github.com:manjunath724/match-scoring-system.git
```
- Switch to feature branch
```
  git checkout manjunath/tennis-scoring-system
```
- Change the directory
```
  cd solution
```
- bundle
```
  bundle install
```
- Run Rspec tests
```
  bundle exec rspec spec
```
or
```
  bundle exec rspec spec/scoring_system/tennis/match_spec.rb
```
