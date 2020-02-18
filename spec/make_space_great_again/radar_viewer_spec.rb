require "spec_helper"
require "make_space_great_again"

describe MakeSpaceGreatAgain::RadarViewer do

  let (:sample_path) { 'spec/fixtures/small_sample' }

  it "should print the sample" do
    radar_sample = MakeSpaceGreatAgain::RadarSample.read sample_path

    expected_str = File.read(sample_path)

    expect(MakeSpaceGreatAgain::RadarViewer.render(radar_sample)).to eq(expected_str)
  end
end
