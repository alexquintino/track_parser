module TrackDecomposer
  class Decomposer


    def self.do(track)
      self.new(track).decompose
    end

    def initialize(track)
      @track = Track.new(track)
    end

    def decompose
      if @track.decomposable?
        @artists = Artists.new(@track.artists)
        @name = @track.trackname
        if @track.has_remix?
          @remix = Remix.new(@track.remix)
        else 
          @remix = NullRemix
        end
      else
        raise UndecomposableTrack.new("Don't know how to decompose a track without \"-\". Track was:#{@track.to_s}")
      end
      {artists: @artists.to_a, name: @name.to_s, remixer: @remix.remixer, remix_name: @remix.remix_name}
    end

  end

  class UndecomposableTrack < StandardError; end 
end