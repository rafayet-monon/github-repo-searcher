# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do

    # use headless_chrome, by default
    driven_by :headless_chrome
  end
end
