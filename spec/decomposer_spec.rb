describe TrackDecomposer::Decomposer do
  
  tracks = ["SIS - Orgsa"]

  let(:decomposed_track) { TrackDecomposer::Decomposer.do(track) }

  context "#{tracks[0]}" do
    let(:track) { tracks[0] }

    it "returns the artist correctly" do
      expect(decomposed_track.artists.first).to eq("SIS")
    end

    it "returns the track name correctly" do
      expect(decomposed_track.name).to eq("Orgsa")
    end
  end

end