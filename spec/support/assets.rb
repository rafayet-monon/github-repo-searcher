# frozen_string_literal: true

RSpec.configure do |config|
  config.when_first_matching_example_defined(type: :system) do
    `bundle exec rails assets:precompile RAILS_ENV=test`
  end
end
