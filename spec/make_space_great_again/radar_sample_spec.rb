require "spec_helper"
require "make_space_great_again"

describe MakeSpaceGreatAgain::RadarSample do
  let (:small_sample_path) { 'spec/fixtures/small_sample' }

  context "interface" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path) }

    it { is_expected.to respond_to(:count) }
    it { is_expected.to respond_to(:row) }
    it { is_expected.to respond_to(:column_size) }
    it { is_expected.to respond_to(:row_size) }
    it { is_expected.to respond_to(:to_a) }
  end

  context "parsing radar sample"  do
    let (:missing_sample_path) { 'spec/fixtures/missing' }
    
    it "should read the file" do
      radar_sample = MakeSpaceGreatAgain::RadarSample.read small_sample_path

      expect(radar_sample.sample.row_size).to eq(IO.readlines(small_sample_path).size)
    end

    it "should raise if it can't find sample" do
      expect {
        MakeSpaceGreatAgain::RadarSample.read(missing_sample_path)
      }.to raise_error(MakeSpaceGreatAgain::RadarSampleNotFound, "#{missing_sample_path} not found")
    end
  end

  context "#get_sub_sample" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).get_sub_sample(0..2, 0..2) }

    it{ is_expected.to be_kind_of(MakeSpaceGreatAgain::RadarSample) }

    it "should return a sample of the correct size" do
      expect(subject.count).to eq(9)
    end
  end
  
  context "#row" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).row(0) }

    it { is_expected.to be_kind_of(Vector) }

    it "is expected to return nil for a missing row" do
      missing_row_index = IO.readlines(small_sample_path).count
      row = MakeSpaceGreatAgain::RadarSample.read(small_sample_path).row(missing_row_index)

      expect(row).to be_nil
    end
  end

  context "#column" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).column(0) }

    it { is_expected.to be_kind_of(Vector) }

    it "is expected to return nil for a missing column" do
      missing_col_index = IO.readlines(small_sample_path).first.strip.split('').count
      col = MakeSpaceGreatAgain::RadarSample.read(small_sample_path).row(missing_col_index)

      expect(col).to be_nil
    end
  end

  context "#row_size" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).row_size }

    it { is_expected.to eq(IO.readlines(small_sample_path).count) }
  end

  context "#col_size" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).column_size }

    it { is_expected.to eq(IO.readlines(small_sample_path).first.strip.split('').count) }
  end

  context "#to_a" do
    subject { MakeSpaceGreatAgain::RadarSample.read(small_sample_path).to_a }

    it { is_expected.to be_kind_of(Array) }
    it { is_expected.to include(a_kind_of(Array)) }
  end
end
