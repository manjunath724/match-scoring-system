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

  # Verify the point_won_by method to increment the points of the player and opponent.
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
  end

  # Validate the score method to return the score of the match in the format of 'set-set', 'set-set, point-point'.
  describe '#score' do
    context 'when the match is in progress' do
      it 'returns the score of the match' do
        match.pointWonBy('player 1')
        match.pointWonBy('player 2')
        expect(match.score).to eq('0-0, 15-15')
      end
    end
  end
end
