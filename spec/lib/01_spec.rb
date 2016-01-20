
require "spec_helper"

# Attempt to source inexistent path.
RSpec.describe "lib/01" do
  # Capture exception.
  e = begin
    include_context_for "other/path"
  rescue
    $!
  end

  it "generally works" do
    expect(e.class).to eq ArgumentError
    expect(e.message).to match %r{\AFile 'other/path' is not located under}
  end
end
