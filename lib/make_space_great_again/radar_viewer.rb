module MakeSpaceGreatAgain

  # Basic way to format a radar sample into a strings
  
  class RadarViewer

    # Returns the radar sample as a formatted string
    #
    # @param sample [RadarSample] the sample to preview
    # @return [String]
    def self.render sample
      str = ""

      sample.to_a.each do |line|
        str += line.join('')
        str += "\n"
      end

      str
    end
  end
end
