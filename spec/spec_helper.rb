
# The feature we're testing.
require "rspec/include_context_for"

# Source developer-local spec helper.
File.exists?(fn = File.expand_path("../spec_local.rb", __FILE__)) and require fn

# Load shared contexts.
Dir[File.expand_path("../shared_contexts/**/*.rb", __FILE__)].each {|fn| require fn}
