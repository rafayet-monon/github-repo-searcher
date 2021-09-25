# frozen_string_literal: true

class RepositorySearcherController < ApplicationController
  def index; end

  def search
    query = params[:search]
    search_data = ::RepositorySearcherService.perform(query, params[:page])

    render 'index', locals: { result: search_data.result,
                              pagination: search_data.pagination,
                              error: search_data.error }
  end
end
