Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  resources :users
  resources :posts
end
