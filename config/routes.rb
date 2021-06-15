Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    resources :stamps, only: [:index]
    resources :stampbooks, only: [:index, :show, :new, :create]
    resources :itineraries, only: [:new, :create, :index, :show]
  end

  resources :stampbooks do
    resources :stamps, only: [:index, :show, :edit, :update]
  end

  resources :itineraries, only: [:show, :destroy] do
    post :activate
    resources :itinerary_items, only: [:index, :new, :create]
    member do
      get :filter
    end
  end

  resources :itinerary_items, only: [:show, :destroy]
end
