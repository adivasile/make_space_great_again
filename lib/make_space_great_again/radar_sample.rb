require "active_support"
require "active_support/core_ext/object"
require 'matrix'

# This represents a radar sample as a matrix

module MakeSpaceGreatAgain
  class RadarSample
    attr_accessor :sample

    # Initializes a RadarSample from a file
    #
    # @param radar_sample [String] The path to the file containing the sample
    # @return [MakeSpaceGreatAgain::RadarSample]
    def self.read radar_sample
      sample = []

      begin
        File.foreach(radar_sample) do |line|
          sample << line.strip.split('')
        end
      rescue
        raise RadarSampleNotFound, "#{radar_sample} not found"
      end

      return self.new(sample)
    end
   
    # Constructor for a RadarSample
    #
    # @param sample [Array] Expects an array of arrays to build the matrix
    def initialize sample
      @sample = Matrix[*sample]
    end

    # Returns a sub sample of the original sample
    #
    # @param row_range [Range] Range of rows to return
    # @param col_range [Range] Range of columns to return
    #
    # @return [MakeSpaceGreatAgain::RadarSample]
    def get_sub_sample(row_range, col_range)
      RadarSample.new @sample.minor(row_range, col_range)
    end

    # Returns count of all elements in the sample
    #
    # @return [Integer]
    def count
      return @sample.count
    end

    # Returns a vector for specified row
    #
    # @param row_index [Integer] Index of row to return
    # @return [Vector]
    def row row_index
      @sample.row(row_index)
    end

    # Returns a vector for the specified column
    #
    # @param col_index [Integer] Index of column to return
    # @return [Vector]
    def column col_index
      @sample.row(col_index)
    end

    # Returns the number of columns in the sample
    #
    # @return [Integer]
    def column_size
      @sample.column_size
    end

    # Returns the number of rows in the sample
    #
    # @return [Integer]
    def row_size
      @sample.row_size
    end

    # Returns the whole matrix as an array of arrays
    #
    # @return [Array]
    def to_a
      return @sample.to_a
    end
  end
end
