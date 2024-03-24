module ScoringSystem
  module Tennis
    class Match
      # Include the helper modules to access the constants and methods.
      include ScoringSystem::Tennis::Helpers::Constants
      include ScoringSystem::Tennis::Helpers::ConstraintChecker
      include ScoringSystem::Tennis::Helpers::ScoreHelper

      attr_accessor :player, :opponent

      # Struct to define the contestant object with the name, set, game, point, advantage and winner attributes.
      Contestant = Struct.new(:name, :set, :game, :point, :advantage, :winner) do
        def initialize(name, set = 0, game = 0, point = 0, advantage = false, winner = false)
          super
        end
      end

      def initialize(player, opponent)
        @player = Contestant.new(player)
        @opponent = Contestant.new(opponent)
        @deuce = false
      end

      # Each time a player wins a point, the point_won_by method is called to increment the points of the contestant.
      def point_won_by(contestant)
        increment_point(contestant)
      end

      # Return the current set score followed by the current game score of the match.
      def score
        "#{player.set}-#{opponent.set}#{game_result}"
      end

      private

      def players
        [@player, @opponent]
      end

      # Increment the scored point of the contestant.
      def increment_point(contestant)
        is_player?(contestant) ? @player.point += 1 : @opponent.point += 1
      end

      # Snake-case is the preferred naming convention for methods.
      # This alias method is defined to maintain the consistency of the method names.
      alias_method :pointWonBy, :point_won_by
    end
  end
end
