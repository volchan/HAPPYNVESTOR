Rails.application.routes.draw do
  require "sidekiq/web"
  mount ActionCable.server, at: '/cable'
  mount Attachinary::Engine => "/attachinary"

  devise_for :users
  root to: 'pages#home'
  resources :searches, only: [:index, :show, :new, :create, :destroy], shallow: true
  resources :results, only: [:show]
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
