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
end
