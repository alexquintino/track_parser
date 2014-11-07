describe TrackParser::Parser do

  tracks = {
    "SIS - Orgsa" =>
      { artists: ["SIS"], name: "Orgsa" },
    "Roy Davis Jr - About Love (Pezzner Remix)" =>
      { artists: ["Roy Davis Jr"], name: "About Love", remixer: ["Pezzner"] },
    "Julien Perez & Octavio Camino - Parada Maya" =>
      { artists: ["Julien Perez", "Octavio Camino"], name: "Parada Maya" },
    "Kollektiv Turmstrasse - Ordinary (Lake People's Circle Motive Remix)" =>
      { artists: ["Kollektiv Turmstrasse"], name: "Ordinary", remixer: ["Lake People"], remix_name: "Circle Motive Remix" },
    "Derek Marin - We've Been Expecting You - Hreno's Deep Pockets Dub" =>
      { artists: ["Derek Marin"], name: "We've Been Expecting You", remixer: ["Hreno"], remix_name: "Deep Pockets Dub" },
     "Umek & Uto Karem - Crossing the Lines - Original Mix" =>
     { artists: ["Umek", "Uto Karem"], name: "Crossing the Lines" },
     "Noir & Fraser Owen - &U - Mendo & Danny Serrano Remix" =>
     { artists: ["Noir", "Fraser Owen"], name: "&U", remixer: ["Mendo", "Danny Serrano"]}
  }

  let(:parsed_track) { TrackParser::Parser.do(track) }

  tracks.keys.each do |track|
    context "#{track}" do
      let(:track) { track }

      it "returns the artist correctly" do
        expect(parsed_track[:artists]).to eq(tracks[track][:artists])
      end

      it "returns the track name correctly" do
        expect(parsed_track[:track_name]).to eq(tracks[track][:name])
      end

      it "returns the remixer correctly" do
        expect(parsed_track[:remixer]).to eq(tracks[track][:remixer])
      end

      it "returns the remix name correctly" do
        expect(parsed_track[:remix_name]).to eq(tracks[track][:remix_name])
      end
    end
  end

  context "invalid track" do
    let(:track) { "Invalid Track" }

    it "throws an exception when the track doesn't have \"-\"" do
      expect{TrackParser::Parser.do(track)}.to raise_error(TrackParser::UnparseableTrack)
    end
  end

end
