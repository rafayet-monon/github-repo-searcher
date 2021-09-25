# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Repository Searcher', type: :request do
  describe 'given root url is visited' do
    it 'renders the index view' do
      get '/'

      expect(response).to be_successful
      expect(response.body).to include('Search')
    end
  end

  describe 'given repository search form is submitted and request is successful',
           vcr: 'repository_search/success' do
    it 'renders the search result' do
      get '/repository_searcher/search', params: { search: 'ruby on rails' }

      expect(response).to be_successful
      expect(response.body).to include('rails/rails')
      expect(response.body).to include('activeadmin/activeadmin')
    end
  end

  describe 'given repository search form is submitted and request is not successful',
           vcr: 'repository_search/failure' do
    it 'renders the error message' do
      get '/repository_searcher/search', params: { search: 'ruby on rails' }

      expect(response).to be_successful
      expect(response.body).to include('Not Found')
    end
  end
end
