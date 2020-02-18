require "active_support"
require "active_support/core_ext/object"

# Main class used to detect space invaders

module MakeSpaceGreatAgain
  class InvaderDetector

    # Initializes an InvaderDetector class 
    #
    # @param radar_sample [MakeSpaceGreatAgain::RadarSample] The radar sample in which to search for invaders
    # @param known_invaders [Array<MakeSpaceGreatAgain::RadarSample>] List of invader radar samples of which to look for
    # @return [MakeSpaceGreatAgain::InvaderDetector]
    def initialize(radar_sample, known_invaders, opts = {})

      invalid_input = [known_invaders, radar_sample].flatten.any? do |sample|
        sample.blank? ||
          !sample.is_a?(MakeSpaceGreatAgain::RadarSample) ||
          sample.count == 0
      end

      raise MakeSpaceGreatAgain::InvalidInput if invalid_input
      
      @options = {
        detector: MakeSpaceGreatAgain::RadarAnalyzer,
        confidence: 0.8,
      }

      @radar_sample = radar_sample
      @known_invaders = known_invaders
    end

    # Run through the sample and search for invaders
    # 
    # @return [Array<Hash>]
    def get_threats
      @known_invaders.flat_map do |invader|
        detect_invader invader 
      end   
    end

    private

    # Search for a specific invader in the radar sample
    # 
    # @return [Array<Hash>]
    def detect_invader invader
      invader_height = invader.row_size
      invader_width = invader.column_size

      row_bound = @radar_sample.row_size # - (invader_height / 3)
      col_bound = @radar_sample.column_size #- (invader_width / 3)

      threats = []

      for row in (0...row_bound)
        for col in (0...col_bound)
          sub_sample = @radar_sample.get_sub_sample(row...invader_height + row, col...invader_width + col)

          match_percentage = @options[:detector].compare sub_sample, invader

          if match_percentage > @options[:confidence]
            threats << {
              row: row,
              col: col,
              radar_sample: MakeSpaceGreatAgain::RadarViewer.render(sub_sample),
              confidence: match_percentage,
            }
          end
        end

      end
      threats
    end
  end
end
