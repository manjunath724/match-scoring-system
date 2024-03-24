# List of edge cases that cover all possible scenarios like deuce, advantage, winner, tie-break etc. in a tennis match.
EDGE_CASES = [
  [0, 0, '0-0'],
  [1, 1, '0-0, 15-15'],
  [2, 2, '0-0, 30-30'],
  [3, 3, '0-0, Deuce'],
  [4, 4, '0-0, Deuce'],

  [1, 0, '0-0, 15-0'],
  [0, 1, '0-0, 0-15'],
  [2, 0, '0-0, 30-0'],
  [0, 2, '0-0, 0-30'],
  [3, 0, '0-0, 40-0'],
  [0, 3, '0-0, 0-40'],
  [4, 0, '0-0, Winner player 1'],
  [0, 4, '0-0, Winner player 2'],

  [2, 1, '0-0, 30-15'],
  [1, 2, '0-0, 15-30'],
  [3, 1, '0-0, 40-15'],
  [1, 3, '0-0, 15-40'],
  [4, 1, '0-0, Winner player 1'],
  [1, 4, '0-0, Winner player 2'],

  [3, 2, '0-0, 40-30'],
  [2, 3, '0-0, 30-40'],
  [4, 2, '0-0, Winner player 1'],
  [2, 4, '0-0, Winner player 2'],

  [4, 3, '0-0, Advantage player 1'],
  [3, 4, '0-0, Advantage player 2'],
  [5, 4, '0-0, Advantage player 1'],
  [4, 5, '0-0, Advantage player 2'],
  [15, 14, '0-0, Advantage player 1'],
  [14, 15, '0-0, Advantage player 2'],

  [6, 4, '0-0, Winner player 1'],
  [4, 6, '0-0, Winner player 2'],
  [16, 14, '0-0, Winner player 1'],
  [14, 16, '0-0, Winner player 2'],

  [6, 4, '0-0, Winner player 1'],
  [4, 6, '0-0, Winner player 2'],
  [6, 5, '0-0, Advantage player 1'],
  [5, 6, '0-0, Advantage player 2'],

  [6, 6, '0-0, Deuce'],
  [12, 12, '0-0, Deuce']
]

# List of test cases that cover all possible scenarios like deuce, advantage, winner, tie-break etc. in a tennis match. But requires coordination of points between players.
TEST_CASES = [
  [6, 3, '0-0, Deuce', 1, 'player 1'],
  [20, 12, '1-0', 4, 'player 1'],
  [16, 20, '0-1', 4, 'player 2'],
  [20, 20, '0-0, Winner player 1', 4, 'player 1'],
  [20, 24, '0-0, Tie-Break', 4, 'player 1'],
  [20, 25, '0-0, Tie-Break', 4, 'player 1'],
  [20, 24, '0-0, 30-0', 6, 'player 1'],
  [20, 20, '1-0', 8, 'player 1'],
  [20, 20, '0-1', 8, 'player 2']
]

# Shared examples to validate the score of the match based on the points scored by the player and opponent.
RSpec.shared_examples 'match score' do |player_points, opponent_points, expectation, more_scored_points = 0, contestant = 'player 1'|
  it "returns the score as #{expectation}" do
    if more_scored_points.zero?
      (0..[player_points, opponent_points].max).each do |t|
        match.point_won_by('player 1') if t < player_points
        match.point_won_by('player 2') if t < opponent_points
      end
    else
      player_points.times { match.point_won_by('player 1') }
      opponent_points.times { match.point_won_by('player 2') }
      more_scored_points.times { match.point_won_by(contestant) }
    end

    expect(match.score).to eq(expectation)
  end
end
