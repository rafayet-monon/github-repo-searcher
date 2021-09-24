# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RepositorySearchers', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/repository_searcher/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    it 'returns http success' do
      get '/repository_searcher/search'
      expect(response).to have_http_status(:success)
    end
  end
end
