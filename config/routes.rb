Rails.application.routes.draw do
  resources :images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'


  resources :registrations do
    collection do
      get :validate_email
    end
  end

  resources :users, only: [:index, :edit, :update, :destroy]

  resources :admins, only: [:index] do
    collection do
      get :all
      get :approved
      get :pending
      get :rejected
    end
  end
  resources :buyers, only: [:index]
  resources :sellers do
    collection do
      get :approved
      get :pending
      get :rejected
    end
  end
  
  resources :products, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :images
    member do
      put :approve
      put :reject
    end
  end

  resources :favourites, only: [:index, :destroy] do
    member do
      post :add
    end
  end
  resources :carts, only: [:index, :destroy] do
    member do
      post :add
    end
  end

  root 'sessions#new'

end
