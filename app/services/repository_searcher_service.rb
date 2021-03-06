# frozen_string_literal: true

class RepositorySearcherService
  include Pagy::Backend

  MAX_SEARCH_RESULTS = 1000

  attr_reader :result, :total_count, :pagination, :error

  def initialize(query, page)
    @query = query
    @page = page || 1
  end

  def self.perform(query, page)
    new(query, page).perform
  end

  def perform
    begin
      response_body = RepositorySearcherAdapter.search(@query, @page).response_body
      @total_count = response_body[:total_count]
      @result = response_body[:items]
      @pagination, = paginate_result(@result)
    rescue StandardError => e
      @error = e.message
    end

    self
  end

  private

  def paginate_result(array)
    pagy_array(array, { count: max_visible_result, page: @page })
  end

  def max_visible_result
    @total_count > MAX_SEARCH_RESULTS ? MAX_SEARCH_RESULTS : @total_count
  end
end
