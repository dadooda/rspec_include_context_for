
require "spec_helper"

RSpec.describe "lib/b/c/00" do
  include_context_for __FILE__

  it "generally works" do
    expect(vs_).to be true
    expect(vs_lib).to be true
    expect {vs_lib_b}.to raise_error NameError
    expect(vs_lib_b_c).to be true
  end
end
