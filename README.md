
RSpec `include_context_for`
===========================

Load a hierarchy of shared contexts based on file location

## 2017-09 update

**IMPORTANT!** A more compact and easy to use implementation is available at [dadooda/rspec_include_dir_context](https://github.com/dadooda/rspec_include_dir_context), please consider.

## Overview

It's always a good idea to maintain a consistent logical structure for all code in a software project.
Specs are no exception to this.

In an average Web application you've probably got specs of **different types**: specs for models, controllers, serializers, libs, etc.
RSpec supports shared examples, **but** there aren't many working examples on how to structure them properly.
As a result, in 99% of the projects shared examples are just piled up together under meaningless global names, not separated between spec types.

This extension offers a solution to this problem.

## Usage

* Create a number of path-based shared contexts ([RSpec docs](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/shared-context)) named like `"/"`, `"/models"`, etc.
* Make your `spec_helper.rb` load your path-based shared contexts.
* Invoke `include_context_for __FILE__` inside the top-most `describe` block of your spec.

Based on the file argument **a hierarchy** of existing path-based shared contexts **will be loaded**.

## Example

```ruby
#
# The spec file, `spec/controllers/api/photos_spec.rb`:
#
require "spec_helper"

RSpec.describe Api::PhotosController, type: :controller do
  include_context_for __FILE__
  # , and it tries to:
  # `include_context "/"`
  # `include_context "/controllers"`
  # `include_context "/controllers/api"`

  # Your actual tests here...
end

#
# Spec helper, `spec/spec_helper.rb`:
#
require "rspec/include_context_for"

# Load shared contexts.
Dir[File.expand_path("../shared_contexts/**/*.rb", __FILE__)].each {|fn| require fn}
...

#
# A path-based shared context, `spec/shared_contexts/_controllers.rb`:
#
RSpec.shared_context "/controllers" do
  shared_context "as Admin" do        # <--- This shared context is LOCAL to controllers only.
    let(:admin) {create :user, :admin}

    before :each do
      sign_in admin
    end
  end

  ...
end
```

## Setup

This project is a *sub*. Sub setup example is available [here](https://github.com/dadooda/subs#setup).

For more info on subs, click [here](https://github.com/dadooda/subs).

## Cheers!

&mdash; Alex Fortuna, &copy; 2016
