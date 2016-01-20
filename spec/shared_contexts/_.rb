
RSpec.shared_context "/" do
  let(:vs_) {true}
  it "visits '/'" do; end
end

#
# Implementation notes:
#
# * `vs` is short for "visisted". Logical proof of visit, for matching.
# * `it` is a visual proof of visit, for the human.
#
