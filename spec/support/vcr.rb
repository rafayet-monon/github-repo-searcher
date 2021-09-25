# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
  c.ignore_localhost = true
  c.ignore_request do |request|
    URI(request.uri).port == 9200
  end
  c.default_cassette_options = { record: :none, match_requests_on: [:path] }
end
