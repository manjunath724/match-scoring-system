module ScoringSystem
  module Tennis
    module Helpers
      # Module to manage the constants used in the tennis tournament.
      module Constants
        SCORES = %w(0 15 30 40).freeze

        DEUCE = 'Deuce'.freeze

        ZERO_POINT = ->(contestant) { contestant.point.zero? }
      end
    end
  end
end
