Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'

  patch '/orders/:id/finalize', to: 'orders#finalize', as: 'finalize_order'

  resources :orders do
    resources :purchases
    resources :payments, only: [:create, :destroy]
  end

  resources :items do
    resources :item_sizes, except: [:destroy]
  end
end
