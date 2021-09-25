# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositorySearcherAdapter do
  describe '#search' do
    context 'given a query string and a page number and the request was successful',
            vcr: 'repository_search/success' do
      it 'returns self object with response body' do
        query_string = 'ruby on rails'
        page = 1

        response = described_class.search(query_string, page)

        expect(response).to respond_to(:response_body)
      end

      it 'returns 20 items by default' do
        query_string = 'ruby on rails'
        page = 1

        response = described_class.search(query_string, page)

        expect(response.response_body[:items].count).to be(20)
      end
    end

    context 'given a query string and a page number but the request was failed',
            vcr: 'repository_search/failure' do
      it 'raises RequestNotSuccessfulError' do
        query_string = 'ruby on rails'
        page = 1

        expect { described_class.search(query_string, page) }.to raise_error(RepositorySearcherAdapter::RequestNotSuccessfulError)
      end
    end
  end
end
