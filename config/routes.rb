Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :stamps, only: [:index]
    resources :stampbooks, only: [:index, :show]
    resources :itineraries, only: [:new, :create, :index]
  end

  resources :stampbooks do
    resources :stamps, only: [:show, :edit, :update]
  end

  resources :itineraries, only: [:show] do
    resources :itinerary_items, only: [:index, :new, :create]
  end

  resources :itinerary_items, only: [:show, :destroy]
end
