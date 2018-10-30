Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'

  patch '/orders/unfinished_order_mail', to: 'orders#unfinished_order_mail', as: 'unfinished_order_mail'

  patch '/orders/:id/toggle_finalized', to: 'orders#toggle_finalized', as: 'toggle_finalized'
  patch '/orders/:id/toggle_fulfilled', to: 'orders#toggle_fulfilled', as: 'toggle_fulfilled'

  get '/orders/:id/new_purchase', to: 'orders#new_purchase', as: 'orders_new_purchase'
  post '/orders/:id/new_purchase/:item_id/:size_id', to: 'orders#create_purchase', as: 'orders_create_purchase'

  resources :orders do
    resources :purchases
    resources :payments, only: [:create, :destroy]
  end

  # for JSON parsing
  get '/item_sizes/:id', to: 'item_sizes#show'

  resources :items do
    resources :item_sizes, except: [:destroy]
  end

  resources :admin, only: [:index]

  resources :gear_sales, only: [:new, :create, :edit, :update]

  patch '/gear_sales/:id/toggle_active', to: 'gear_sales#toggle_active', as: 'toggle_sale_active'
  patch '/gear_sales/:id/toggle_open', to: 'gear_sales#toggle_open', as: 'toggle_sale_open'

  devise_for :users, :skip => [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
end
