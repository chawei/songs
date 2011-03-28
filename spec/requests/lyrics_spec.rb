require 'spec_helper'

describe "Lyrics" do
  describe "GET /lyrics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get lyrics_path
      response.status.should be(200)
    end
  end
end
