Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root to: redirect('/products')

  resources :products do
  end

  post '/upload_image', to: 'home#upload_image', as: 'upload_image'

  resources :classrooms


  authenticate :user, ->(user) { user.administrator? } do
    resources :administrators, only: [:index] do
      collection do
        post :deposit_all
      end
    end
    resources :classrooms

    post '/administrators/deposit', to: 'administrators#deposit', as: :deposit_administrators
    get '/classroom_management', to: 'administrators#classroom_management', as: 'classroom_management'
    get '/administrator/dashboard', to: 'administrators#dashboard', as: 'admin_dashboard'
    post '/classroom_administrators/add_user', to: 'administrators#add_user_to_classroom', as: 'add_user_to_classroom_administrators'
  end

  resources :investments do
  end

  mount Sidekiq::Web => '/jobs'

  resources :balances, only: [:show] do
    member do
      post 'deposit'
      post 'withdraw'
    end
  end

  resources :transfers, only: [:show, :new, :create] do
    get :confirmation, on: :collection
    post :confirmation, on: :collection
  end

  post '/transfer/confirmation', to: 'transfers#confirmation', as: 'confirmation_transfer'

  resources :users do
    resource :balance, only: [:show] do
      post :deposit
      post :withdraw
    end
    resource :extract, only: [:show]
  end
end
