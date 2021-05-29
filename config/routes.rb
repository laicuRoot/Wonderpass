Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :stamps, only: [:index]
    resources :stampbooks, only: [:index, :show]
  end

  resources :stampbooks do
    resources :stamps, only: [:show, :edit, :update]
  end

  resources :itineraries do
    resources :itinerary_items, only: [:new, :create, :destroy]
  end
end
