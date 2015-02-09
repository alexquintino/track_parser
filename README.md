# TrackParser

Tries to parse the name of a track (e.g. ArtistA - ABC (ArtistB remix)) and extract metadata from it (e.g. artists = ArtistA, track-name = ABC, remixer = ArtistB)
It makes a best effort to extract the metadata by passing the track through a set of rules that most tracks follow. If the track does not follow those rules, the results might not be accurate.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'track_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install track_parser

## Usage

### Simple
```ruby
require "track_parser"
TrackParser::Parser.do("Derek Marin - We've Been Expecting You - Hreno's Deep Pockets Dub")
=> {:artists=>["Derek Marin"], :track_name=>"We've Been Expecting You", :remixer=>"Hreno", :remix_name=>"Deep Pockets Dub"}
```

### Structured
You might know already the artists. In that case you can use:
```ruby
require "track_parser"
TrackParser::Parser.do(artists: ["Derek Marin], name: "We've Been Expecting You - Hreno's Deep Pockets Dub")
=> {:artists=>["Derek Marin"], :track_name=>"We've Been Expecting You", :remixer=>"Hreno", :remix_name=>"Deep Pockets Dub"}
```

## Non-exhaustive list of formats supported (for more check the [tests](https://github.com/alexquintino/track_parser/blob/master/spec/parser_spec.rb))

* `<artist> - <track name>`
* `<artist> - <track name> [-] (<remixer> Remix|Vocal|Dub|Mix)`
* `<artist> - <track name> (<remixer>'s <remix name>)`
* `<artist> & <artist> - <track name>`

## Contributing

1. Fork it ( https://github.com/alexquintino/track_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
