require "spec_helper"
require "make_space_great_again"

describe MakeSpaceGreatAgain::RadarAnalyzer do
  context "on invalid input" do
    it "should raise an InvalidAnalyzerInput exception" do
      expect {
        MakeSpaceGreatAgain::RadarAnalyzer.compare(nil, nil)
      }.to raise_error(MakeSpaceGreatAgain::InvalidInput)
    end
  end

  context "on valid input" do
    let (:invader_path) { "spec/fixtures/invader1" }
    let (:invader) { MakeSpaceGreatAgain::RadarSample.read(invader_path) }

    let (:full_sample_path) { "spec/fixtures/radar_sample" }
    let (:full_sample) { MakeSpaceGreatAgain::RadarSample.read(full_sample_path) }

    let (:analyzer_sample1_path) { 'spec/fixtures/analyzer/sample1' }
    let (:analyzer_sample1) { MakeSpaceGreatAgain::RadarSample.read(analyzer_sample1_path) }

    it "shouldn't raise" do
      expect { MakeSpaceGreatAgain::RadarAnalyzer.compare(full_sample, invader) }.not_to raise_error
    end

    it "should return a float" do
      match_percentage = MakeSpaceGreatAgain::RadarAnalyzer.compare(full_sample, invader) 

      expect(match_percentage).to be_kind_of(Float)
    end

    it "should return a correct result" do
      match_percentage = MakeSpaceGreatAgain::RadarAnalyzer.compare(analyzer_sample1, invader) 

      expect(match_percentage).to eq(0.875)
    end

  end
end
