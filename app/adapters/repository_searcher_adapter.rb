# frozen_string_literal: true

class RepositorySearcherAdapter
  RequestNotSuccessfulError = Class.new(StandardError)

  attr_reader :response_body

  SEARCH_API = 'https://api.github.com/search/repositories'
  QUERY_PARAM = 'q'
  SORT_PARAM = 'sort'
  ORDER_PARAM = 'order'
  PAGE_NUMBER_PARAM = 'page'
  PER_PAGE_PARAM = 'per_page'

  DEFAULT_PER_PAGE = 20
  DEFAULT_SORT_BY = 'stars'
  DEFAULT_ORDER_BY = 'desc'

  def initialize(query_string, page)
    @query = query_string
    @page = page
  end

  def self.search(query_string, page)
    new(query_string, page).search
  end

  def search
    response = make_request
    @response_body = JSON.parse(response.body, symbolize_names: true)
    raise RequestNotSuccessfulError, @response_body[:message] unless response.is_a?(Net::HTTPSuccess)

    self
  end

  private

  def make_request
    uri = URI(SEARCH_API)
    params = {
      QUERY_PARAM => @query,
      SORT_PARAM => DEFAULT_SORT_BY,
      ORDER_PARAM => DEFAULT_ORDER_BY,
      PAGE_NUMBER_PARAM => @page,
      PER_PAGE_PARAM => DEFAULT_PER_PAGE
    }
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end
end
