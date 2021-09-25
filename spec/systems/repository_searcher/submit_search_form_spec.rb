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

  context 'given the search button is clicked' do
    context 'given the request is successful', vcr: 'repository_search/success' do
      it 'displays the search result' do
        visit(root_path)

        within selectors[:search_form] do
          fill_in selectors[:search_field], with: 'ruby on rails'
          click_button selectors[:search_submit]
        end

        expect(page).to have_text 'rails/rails'
        expect(page).to have_text 'activeadmin/activeadmin'
      end
    end

    context 'given the request is not successful', vcr: 'repository_search/failure' do
      it 'displays the error message' do
        visit(root_path)

        within selectors[:search_form] do
          fill_in selectors[:search_field], with: 'ruby on rails'
          click_button selectors[:search_submit]
        end

        expect(page).to have_text 'Not Found'
      end
    end
  end
end
