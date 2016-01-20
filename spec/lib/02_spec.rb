
require "spec_helper"

# Test if shared contexts are context-local.
RSpec.describe "lib/02" do
  describe "context 1" do
    shared_context "shared" do
      let(:marker) {true}
      it "visits `shared`" do; end
    end

    include_context "shared"

    it "sees `shared`" do
      expect(marker).to be true
    end
  end

  describe "context 2" do
    # Capture exception.
    e = begin
      include_context "shared"
    rescue
      $!
    end

    it "doesn't see `shared`" do
      expect([e.class, e.message]).to eq [ArgumentError, "Could not find shared context \"shared\""]
    end
  end
end
