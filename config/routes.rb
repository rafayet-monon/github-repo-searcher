Rails.application.routes.draw do
  root to: 'repository_searcher#index'

  get 'repository_searcher/search'
end
