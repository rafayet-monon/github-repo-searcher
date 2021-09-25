# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.ignore_request do |request|
    URI(request.uri).port == 9200
  end
end
