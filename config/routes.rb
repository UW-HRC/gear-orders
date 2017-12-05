Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'

  patch '/orders/:id/toggle_finalized', to: 'orders#toggle_finalized', as: 'toggle_finalized'
  patch '/orders/:id/toggle_fulfilled', to: 'orders#toggle_fulfilled', as: 'toggle_fulfilled'

  resources :orders do
    resources :purchases
    resources :payments, only: [:create, :destroy]
  end

  # for JSON parsing
  get '/item_sizes/:id', to: 'item_sizes#show'

  resources :items do
    resources :item_sizes, except: [:destroy]
  end

  devise_for :users, :skip => [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
end
