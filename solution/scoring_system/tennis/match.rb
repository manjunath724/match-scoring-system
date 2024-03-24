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

      # Increments the points scored by the contestant.
      # Reset the previous flags and update the game and set/set flags based on the points scored by the players.
      def point_won_by(contestant)
        reset_flags
        increment_point(contestant)
        update_game_and_set
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

      # Update the game and set based on the points scored by the players and conditions applicable.
      def update_game_and_set
        if leading?(player, opponent)
          declare_winner(player)
          reset_points
        elsif leading?(opponent, player)
          declare_winner(opponent)
          reset_points
        elsif eligible_for_winning?
          determine_deuce_vs_advantage
        end
        players.each do |contestant|
          update_set(contestant) if can_finalize_winner?(contestant)
        end
      end

      # In case we plan to restrict the match to 1 set, then invoking this method will reset the sets and games of the players.
      # This method should be invoked in update_game_and_set.
      # def reset_sets_and_games
      #   if (player.set == 1 || opponent.set == 1) && (!player.point.zero? || !opponent.point.zero?)
      #     players.each { |contestant| contestant.set = 0; contestant.game = 0 }
      #   end
      # end

      # Snake-case is the preferred naming convention for methods.
      # This alias method is defined to maintain the consistency of the method names.
      alias_method :pointWonBy, :point_won_by
    end
  end
end
