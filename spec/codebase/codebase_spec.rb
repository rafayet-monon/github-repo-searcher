# frozen_string_literal: true

require 'rails_helper'

describe 'Codebase', codebase: true do
  it 'does not offend Rubocop' do
    expect(`rubocop --parallel --format simple`).to include 'no offenses detected'
  end

  it 'satisfies Brakeman' do
    expect(`brakeman -w2`).not_to include '+SECURITY WARNINGS+'
  end

  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to include 'll is good!'
  end

  it 'does not offend scss-lint' do
    expect(`scss-lint`).to be_empty
  end
end
