# MakeSpaceGreatAgain

## Usage

Install dependencies

    $ bundle

A usage sample can be found in ```detect_invaders.rb```. Run:

    $ bundle exec ruby detect_invaders.rb

Use the ```MakeSpaceGreatAgain::RadarSample``` to read and handle radar sample files

Invader detection is with done with the ```MakeSpaceGreatAgain::InvaderDetector``` class. Initialize with an instance of a ```RadarSample``` in which to search for invaders and a list of radar samples of known invaders. Also accepts an options hash to set the confidence threshold or use a different detection algorithm

To run tests:

    $ bundle exec rspec

To generate Yard doc files:

    $ bundler exec yard doc

and open ```doc/index.html```


## Classes

#### MakeSpaceGreatAgain::RadarSample

Handles parsing and handling of a radar sample. It's used for both invaders and the radar sample.
Samples are defined as a ruby Matrix class and it exposes some basic functions from the Matrix class

#### MakeSpaceGreatAgain::InvaderDetector

The class that runs the actual detection. It's initialized with a radar sample, a list of known invaders and an options hash.

In the options hash you can define:
* ```:confidence``` - the confidence threshold for something to be a threat
* ```:detector``` - a detector class which will do the actual comparison of the invader to the radar sample
* ```:threat_renderer``` - a threat_renderer used to convert a slice of the sample to a printable string

#### MakeSpaceGreatAgain::RadarAnalyzer

Implementation of a detection algorithm. Needs to expose a class method named ```compare``` which will be called with 2 instance of RadarSample and is expected to return a float

#### MakeSpaceGreatAgain::RadarViewer

Basic class to convert a radar sample matrix to a printable string

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
