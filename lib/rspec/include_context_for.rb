
require "pathname"
require "rspec/core/ruby_project"

module RSpec
  module IncludeContextFor
    module Helpers
      # Load a hierarchy of shared contexts based on file location.
      #
      #   RSpec.describe Api::PhotosController, type: :controller do
      #     include_context_for __FILE__
      #     # , and it tries to:
      #     # `include_context "/"`
      #     # `include_context "/controllers"`
      #     # `include_context "/controllers/api"`
      #
      #     # Your actual tests here...
      #   end
      def include_context_for(filename)
        spec_path = Pathname(RSpec::Core::RubyProject.determine_root) + "spec"   # => "/path/to/project/spec"

        rel = begin     # => "lib", "lib/sub/path", "models" etc.
          Pathname(filename).relative_path_from(spec_path).dirname
        rescue ArgumentError
          raise ArgumentError, "File '#{filename}' is not located under '#{spec_path}'"
        end

        context = ""
        pcs = ["/"] + rel.to_s.split("/")

        pcs.each do |piece|
          context = File.join(context, piece)

          begin
            include_context(context)
          rescue ArgumentError => e
            # Skip if context not found.
            # Re-raise if that's some other `ArgumentError` we're not aware of.
            if e.message.start_with?("Could not find shared context")
              ##puts "Shared context not found: #{context.inspect}"
            else
              raise e
            end
          end
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.extend RSpec::IncludeContextFor::Helpers
end
