# frozen_string_literal: true

require 'rails_helper'

describe 'View Repository Search Index Page', type: :system do
  let(:selectors) do
    {
      search_form: '.form-search',
      search_field: 'search',
      search_submit: 'Search'
    }
  end

  it 'shows the search form' do
    visit(root_path)

    within(selectors[:search_form]) do
      expect(page).to have_field(selectors[:search_field])
      expect(page).to have_button(selectors[:search_submit])
    end
  end
end
