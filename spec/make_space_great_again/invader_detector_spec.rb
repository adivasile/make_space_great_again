require "spec_helper"
require "make_space_great_again"

describe MakeSpaceGreatAgain::InvaderDetector do

  let (:sample_path) { 'spec/fixtures/radar_sample' }
  let (:invader_path) { 'spec/fixtures/invader1' }

  let (:radar_sample) { MakeSpaceGreatAgain::RadarSample.read sample_path }
  let (:invader_sample) { MakeSpaceGreatAgain::RadarSample.read invader_path }

  context "invalid input" do
    it "should raise if called with bad types" do
      expect {
        MakeSpaceGreatAgain::InvaderDetector.new(nil, [])
      }.to raise_error(MakeSpaceGreatAgain::InvalidInput)
    end

    it "should raise if called with nils" do
      expect {
        MakeSpaceGreatAgain::InvaderDetector.new(nil, nil)
      }.to raise_error(MakeSpaceGreatAgain::InvalidInput)
    end
  end
 
  context "interface" do
    subject { MakeSpaceGreatAgain::InvaderDetector.new(radar_sample, [invader_sample], { confidence: 0.5 }) }

    it { should respond_to(:get_threats) }

    it "should override default options with passed options" do
      expect(subject.instance_variable_get(:@options)[:confidence]).to eq(0.5)
    end
  end

  context "missing invaders" do
    subject { MakeSpaceGreatAgain::InvaderDetector.new(radar_sample, []).get_threats }

    it { should be_blank }
  end

  context "#get_threats" do
    subject { MakeSpaceGreatAgain::InvaderDetector.new(radar_sample, [invader_sample]).get_threats }

    it { is_expected.to be_kind_of(Array) }

    it { is_expected.to include(a_kind_of(Hash)) }

    it "should correct format of threats" do
      expect(subject.first).to include(:row, :col, :radar_sample, :confidence)
    end
  end
end
