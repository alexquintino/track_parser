describe TrackDecomposer::Decomposer do
  
  tracks = {
    "SIS - Orgsa" => 
      { artists: ["SIS"], name: "Orgsa", remixer: nil, remix_name: nil },
    "Roy Davis Jr - About Love (Pezzner Remix)" => 
      { artists: ["Roy Davis Jr"], name: "About Love", remixer: "Pezzner", remix_name: nil },
    "Julien Perez & Octavio Camino - Parada Maya" => 
      { artists: ["Julien Perez", "Octavio Camino"], name: "Parada Maya", remixer: nil, remix_name: nil },
    "Kollektiv Turmstrasse - Ordinary - (Lake People's Circle Motive Remix)" => 
      { artists: ["Kollektiv Turmstrasse"], name: "Ordinary", remixer: "Lake People", remix_name: "Circle Motive Remix" },
    "Derek Marin - We've Been Expecting You - Hreno's Deep Pockets Dub" => 
      { artists: ["Derek Marin"], name: "We've Been Expecting You", remixer: "Hreno", remix_name: "Deep Pockets Dub" }
  }

  let(:decomposed_track) { TrackDecomposer::Decomposer.do(track) }

  tracks.keys.each do |track|
    context "#{track}" do
      let(:track) { track }

      it "returns the artist correctly" do
        expect(decomposed_track[:artists]).to eq(tracks[track][:artists])
      end

      it "returns the track name correctly" do
        expect(decomposed_track[:name]).to eq(tracks[track][:name])
      end

      it "returns the remixer correctly" do
        expect(decomposed_track[:remixer]).to eq(tracks[track][:remixer])
      end

      it "returns the remix name correctly" do
        expect(decomposed_track[:remix_name]).to eq(tracks[track][:remix_name])
      end
    end
  end

  context "invalid track" do
    let(:track) { "Invalid Track" }

    it "throws an exception when the track doesn't have \"-\"" do
      expect{TrackDecomposer::Decomposer.do(track)}.to raise_error(TrackDecomposer::UndecomposableTrack)
    end
  end

end