module ScoringSystem
  module Tennis
    module Helpers
      # Module to manage the constants used in the tennis tournament.
      module Constants
        SCORES = %w(0 15 30 40).freeze

        # Various states of the game. Used to determine the winner, advantage, deuce, tie-break etc.
        TIE_BREAK = 'Tie-Break'.freeze

        DEUCE = 'Deuce'.freeze

        ADVANTAGE = 'Advantage'.freeze

        WINNER = 'Winner'.freeze

        # Lambda functions to validate the points scored and games won by the contestants.
        GTE_THREE = ->(contestant) { contestant.point >= 3 }

        ZERO_POINT = ->(contestant) { contestant.point.zero? }

        TIE_BREAK_GAME = ->(contestant) { contestant.game == 6 }
      end
    end
  end
end
