require 'make_space_great_again'

radar_sample = MakeSpaceGreatAgain::RadarSample.read("spec/fixtures/radar_sample")
invader1 = MakeSpaceGreatAgain::RadarSample.read("spec/fixtures/invader1")
invader2 = MakeSpaceGreatAgain::RadarSample.read("spec/fixtures/invader2")

detector = MakeSpaceGreatAgain::InvaderDetector.new radar_sample, [ invader1, invader2 ], { confidence: 0.7 }

threats = detector.get_threats

threats.each do |threat|
  puts "Threat found at #{threat[:row]}:#{threat[:col]}. Confidence: #{threat[:confidence]}"
  puts threat[:radar_sample]

  puts
end
