# frozen_string_literal: true

class RepositorySearcherController < ApplicationController
  def index; end

  def search
    search_data = ::RepositorySearcherService.perform(params[:search], params[:page])

    render 'index', locals: { result: search_data.result,
                              pagination: search_data.pagination,
                              error: search_data.error }
  end
end
