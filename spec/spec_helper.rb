require 'simplecov'

SimpleCov.start do
  add_filter                "vendor"
  add_filter                "spec"
end

require File.expand_path("../../lib/saltine", __FILE__)
