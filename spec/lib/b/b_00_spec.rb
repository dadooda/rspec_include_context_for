
require "spec_helper"

RSpec.describe "lib/b/00" do
  include_context_for __FILE__

  it "generally works" do
    expect(vs_).to be true
    expect(vs_lib).to be true
    expect {vs_lib_b}.to raise_error NameError
  end
end
