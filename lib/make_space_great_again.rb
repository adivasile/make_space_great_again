require "make_space_great_again/version"
require "make_space_great_again/radar_sample"
require "make_space_great_again/invader_detector"
require "make_space_great_again/radar_viewer"
require "make_space_great_again/radar_analyzer"
require "matrix"
require "pry"

module MakeSpaceGreatAgain
  class Error < StandardError; end
  class RadarSampleNotFound < StandardError; end
  class InvalidInput < StandardError; end
end
