require "active_support"
require "active_support/core_ext/object"
require 'matrix'


# Implements the radar to invadar comparison algorithm

module MakeSpaceGreatAgain
  class RadarAnalyzer

    # Run the comparison
    #
    # @param sample1 [MakeSpaceGreatAgain::RadarSample]
    # @param sample2 [MakeSpaceGreatAgain::RadarSample]
    # @return [Float] The percetange of values that matched in the sample
    def self.compare(sample1, sample2)

      invalid_input = [sample1, sample2].any? do |sample|
        sample.blank? ||
          !sample.is_a?(MakeSpaceGreatAgain::RadarSample) ||
          sample.count == 0
      end

      raise MakeSpaceGreatAgain::InvalidInput if invalid_input

      matches = 0
      # Use the largest sample row count to iterate
      # Missing values in the other sample will be ignored and not counted as matches
      row_count = [sample1.row_size, sample2.row_size].max

      for i in (0...row_count)
        row1 = sample1.row(i) || []
        row2 = sample2.row(i) || []

        row1.each_with_index do |val, idx|
          matches += 1 if row2[idx].present? && val == row2[idx]
        end
      end

      return matches.to_f / [sample1.count, sample2.count].max
    end
  end
end
