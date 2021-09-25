# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositorySearcherService do
  describe '#perform' do
    context 'given a query string and a page number and the request was successful',
            vcr: 'repository_search/success' do
      it 'returns self object with result, total_count, pagination and error' do
        response = described_class.perform('ruby on rails', 1)

        expect(response).to respond_to(:result)
        expect(response).to respond_to(:total_count)
        expect(response).to respond_to(:pagination)
        expect(response).to respond_to(:error)
      end

      it 'returns total_count with a number' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.total_count).to be(88_693)
      end

      it 'returns result with 20 items by default' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.result.count).to be(20)
      end

      it 'returns pagination with pagy object' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.pagination).to be_a_kind_of(Pagy)
      end

      it 'returns error in the self object with nil' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.error).to be(nil)
      end
    end

    context 'given a query string and a page number but the request was failed',
            vcr: 'repository_search/failure' do
      it 'returns error in self object with error message' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.error).to eq('Not Found')
      end

      it 'returns result, total_count and pagination in self object with nil' do
        response = described_class.perform('ruby on rails', 1)

        expect(response.result).to be(nil)
        expect(response.total_count).to be(nil)
        expect(response.pagination).to be(nil)
      end
    end
  end
end
