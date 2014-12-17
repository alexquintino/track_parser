describe TrackParser::Parser do

  tracks = {
    "SIS - Orgsa" =>
      { artists: ["SIS"], name: "Orgsa", remixer: nil, remix_name: nil},
    "Roy Davis Jr - About Love (Pezzner Remix)" =>
      { artists: ["Roy Davis Jr"], name: "About Love", remixer: ["Pezzner"], remix_name: "Remix" },
    "Julien Perez & Octavio Camino - Parada Maya" =>
      { artists: ["Julien Perez", "Octavio Camino"], name: "Parada Maya", remixer: nil, remix_name: nil},
    "Kollektiv Turmstrasse - Ordinary (Lake People's Circle Motive Remix)" =>
      { artists: ["Kollektiv Turmstrasse"], name: "Ordinary", remixer: ["Lake People"], remix_name: "Circle Motive Remix" },
    "Derek Marin - We've Been Expecting You - Hreno´s Deep Pockets Dub" =>
      { artists: ["Derek Marin"], name: "We've Been Expecting You", remixer: ["Hreno"], remix_name: "Deep Pockets Dub" },
    "Umek & Uto Karem - Crossing the Lines - Original Mix" =>
      { artists: ["Umek", "Uto Karem"], name: "Crossing the Lines", remixer: nil, remix_name: "Original Mix" },
    "Noir & Fraser Owen - &U - Mendo and Danny Serrano Remix" =>
      { artists: ["Noir", "Fraser Owen"], name: "&U", remixer: ["Mendo", "Danny Serrano"], remix_name: "Remix"},
    "Plastikman - Spastik - Dubfire Rework" =>
      { artists: ["Plastikman"], name: "Spastik", remixer: ["Dubfire"], remix_name: "Rework" },
    "Alex Under - El Encuentro - Richie Hawtin Edit" =>
      { artists: ['Alex Under'], name: 'El Encuentro', remixer: ["Richie Hawtin"], remix_name: "Edit" },
    "Gorge - Erotic Soul feat. The Writers Poet - Original Mix" =>
      { artists: ["Gorge"], name: "Erotic Soul", featuring: ["The Writers Poet"], remixer: nil, remix_name: "Original Mix"},
    "John Talabot & Pional - Destiny (Feat. Pional)" =>
      { artists: ["John Talabot", "Pional"], name: "Destiny", featuring: ["Pional"], remixer: nil, remix_name: nil},
    "Ornette - Crazy - Nôze Remix - Extended Club Version" =>
      { artists: ["Ornette"], name: "Crazy", remixer: ["Nôze"], remix_name: "Remix Extended Club Version" },
    "2 Guys in Venice & Spiller & Digitalism - Encore - Spiller & 2 Guys In Venice Remix" =>
      { artists: ["2 Guys in Venice", "Spiller", "Digitalism"], name: "Encore", remixer: ["Spiller", "2 Guys In Venice"], remix_name: "Remix" },
    "Subb-an - Take You Back (ft. Beckford)" =>
      { artists: ["Subb-an"], name: "Take You Back", featuring: ["Beckford"] },
    "Aki Bergen & Pezzner & Terry Grant - Tarareando - Vocal Mix" =>
      { artists: ["Aki Bergen", "Pezzner", "Terry Grant"], name: "Tarareando", remixer: nil, remix_name: "Vocal Mix" },
    "Jay Haze & Laila Tov - I Wait For You - Original" =>
      { artists: ["Jay Haze", "Laila Tov"], name: "I Wait For You", remixer: nil, remix_name: "Original"},
    "DJ T. - City Life - feat. Cari Golden [Maceo Plex Remix]" =>
      { artists: ["DJ T."], name: "City Life", remixer: ["Maceo Plex"], remix_name: "Remix", featuring: ["Cari Golden"]},
    "Fritz Kalkbrenner - Right in the Dark - Henrik Schwarz Remix - Chopstick & Johnjon Edit" =>
      { artists: ["Fritz Kalkbrenner"], name: "Right in the Dark", remixer: ["Henrik Schwarz", "Chopstick", "Johnjon"], remix_name: "Remix Edit"}
  }

  tracks_structured = [
    {track: { artists: ["Sailor & I"], name: "Tough Love - Aril Brikha Remix" }, result:
      { artists: ["Sailor & I"], name: "Tough Love", remixer: ["Aril Brikha"], remix_name: "Remix"}}
  ]

  let(:parsed_track) { TrackParser::Parser.do(track) }

  tracks.keys.each do |track|
    context "#{track}" do
      let(:track) { track }

      it "returns the artist correctly" do
        expect(parsed_track.artists).to eq(tracks[track][:artists])
      end

      it "returns the track name correctly" do
        expect(parsed_track.name).to eq(tracks[track][:name])
      end

      it "returns the remixer correctly" do
        expect(parsed_track.remixer).to eq(tracks[track][:remixer])
      end

      it "returns the remix name correctly" do
        expect(parsed_track.remix_name).to eq(tracks[track][:remix_name])
      end

      it "returns the featured artists correctly" do
        expect(parsed_track.featuring).to eq(tracks[track][:featuring])
      end
    end
  end

  context "invalid track" do
    let(:track) { "Invalid Track" }

    it "throws an exception when the track doesn't have \"-\"" do
      expect{TrackParser::Parser.do(track)}.to raise_error(TrackParser::UnparseableTrack)
    end
  end

  context "Hash as input" do
    let(:track) { tracks_structured.first[:track] }
    let(:result) { tracks_structured.first[:result]}

    it "returns all the correct info" do
      expect(parsed_track.artists).to eq(result[:artists])
      expect(parsed_track.name).to eq(result[:name])
      expect(parsed_track.remixer).to eq(result[:remixer])
      expect(parsed_track.remix_name).to eq(result[:remix_name])
      expect(parsed_track.featuring).to eq(result[:featuring])
    end
  end

end
