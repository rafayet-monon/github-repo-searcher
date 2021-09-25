# frozen_string_literal: true

class RepositorySearcherService
  attr_reader :result, :total_count, :pagination, :error

  def initialize(query, page)
    @query = query
    @page = page
  end

  def self.perform(query, page = 1)
    new(query, page).perform
  end

  def perform
    begin
      response_body = RepositorySearcherAdapter.search(@query, @page).response_body
      @total_count = response_body['total_count']
      @result = response_body['items']
      @pagination = paginate_result
    rescue StandardError => e
      @error = e.message
    end

    self
  end

  private

  def paginate_result
    Kaminari.paginate_array(@result, total_count: @total_count).page(@page)
  end
end
