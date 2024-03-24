RSpec.describe ScoringSystem::Tennis::Match do
  let(:match) { described_class.new('player 1', 'player 2') }

  # Validate default state of the player object in a match.
  describe '#initialize' do
    it 'initializes a match with two players' do
      expect(match.player.name).to eq('player 1')
      expect(match.opponent.name).to eq('player 2')
    end

    it 'initializes game set and point of players to zero' do
      expect(match.player.set).to eq(0)
      expect(match.opponent.set).to eq(0)
      expect(match.player.game).to eq(0)
      expect(match.opponent.game).to eq(0)
      expect(match.player.point).to eq(0)
      expect(match.opponent.point).to eq(0)
      expect(match.player.advantage).to be_falsy
      expect(match.opponent.advantage).to be_falsy
      expect(match.player.winner).to be_falsy
      expect(match.opponent.winner).to be_falsy
    end

    it 'initializes deuce flag to false' do
      expect(match.instance_variable_get(:@deuce)).to be_falsy
    end
  end

  # Verify the point_won_by method to increment the points of the player and opponent while setting the flags for deuce, advantage and winner. Thus updating the game and set accordingly.
  describe '#point_won_by' do
    context 'when player wins a point' do
      it 'increments the point of the player' do
        match.point_won_by('player 1')
        expect(match.player.point).to eq(1)
      end
    end

    context 'when opponent wins a point' do
      it 'increments the point of the opponent' do
        match.point_won_by('player 2')
        expect(match.opponent.point).to eq(1)
      end
    end

    context 'when either player reaches the game point' do
      it 'updates game and set accordingly' do
        4.times { match.point_won_by('player 1') }
        expect(match.player.game).to eq(1)
        expect(match.player.set).to eq(0)
        expect(match.player.point).to eq(0)
        expect(match.player.winner).to be_truthy

        20.times { match.pointWonBy('player 1') }
        expect(match.player.set).to eq(1)
        expect(match.player.game).to eq(0)
        expect(match.player.point).to eq(0)
        expect(match.player.winner).to be_falsy
      end
    end

    context 'when a player has advantage' do
      it 'resets the advantage if the opponent scores' do
        3.times { match.point_won_by('player 1') }
        3.times { match.point_won_by('player 2') }
        expect(match.instance_variable_get(:@deuce)).to be_truthy

        match.pointWonBy('player 1')
        expect(match.player.advantage).to be_truthy

        match.pointWonBy('player 2')
        expect(match.player.advantage).to be_falsy
        expect(match.opponent.advantage).to be_falsy
      end
    end
  end

  # Validate the score method to return the score of the match in the format of 'set-set', 'set-set, point-point' or 'set-set, <Deuce/Advantage/Winner/Tie-Break>'.
  describe '#score' do
    # Validate the score of the match based on the points scored by the player and opponent.
    context 'when the match is in progress' do
      it 'returns the score of the match' do
        match.pointWonBy('player 1')
        match.pointWonBy('player 2')
        expect(match.score).to eq('0-0, 15-15')

        6.times { match.point_won_by('player 1') }
        3.times { match.point_won_by('player 2') }
        expect(match.score).to eq('0-0, Deuce')

        5.times { match.pointWonBy('player 1') }
        4.times { match.pointWonBy('player 2') }
        expect(match.score).to eq('0-0, Advantage player 2')

        15.times { match.point_won_by('player 2') }
        12.times { match.point_won_by('player 1') }
        expect(match.score).to eq('0-0, Winner player 1')

        8.times { match.pointWonBy('player 2') }
        4.times { match.pointWonBy('player 1') }
        expect(match.score).to eq('0-0, Tie-Break')

        4.times { match.point_won_by('player 1') }
        expect(match.score).to eq('1-0')
      end
    end

    # Validate edge cases of the match like deuce, advantage, winner, tie-break etc.
    EDGE_CASES.each do |testcase|
      player_points, opponent_points, expectation = testcase

      context "when player has #{player_points} points and opponent has #{opponent_points} points" do
        include_examples 'match score', player_points, opponent_points, expectation
      end
    end

    # Validate the score of the match based on the points scored by the player and opponent along with the additional points scored by the contestants.
    TEST_CASES.each do |testcase|
      player_points, opponent_points, expectation, more_scored_points, contestant = testcase

      context "when player has #{player_points} points and opponent has #{opponent_points} points" do
        include_examples 'match score', player_points, opponent_points, expectation, more_scored_points, contestant
      end
    end
  end
end
