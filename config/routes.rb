Rails.application.routes.draw do
  root to: 'static_pages#index'

  # routes for orders
  # standard RESTful routes
  resources :orders, except: [:new, :edit, :update] do
    resources :payments, only: [:create, :destroy]
    resources :purchases, only: [:destroy]
  end

  # path to send email to those with unfinished orders
  patch '/orders/unfinished_order_mail', to: 'orders#unfinished_order_mail', as: 'unfinished_order_mail'

  patch '/orders/:id/toggle_finalized', to: 'orders#toggle_finalized', as: 'toggle_finalized'
  patch '/orders/:id/toggle_fulfilled', to: 'orders#toggle_fulfilled', as: 'toggle_fulfilled'

  get '/orders/:id/new_purchase', to: 'orders#new_purchase', as: 'orders_new_purchase'

  # link a purchase to an order
  post '/orders/:id/new_purchase/:item_id/:size_id', to: 'orders#create_purchase', as: 'orders_create_purchase'

  get '/profile', to: 'users#index', as: 'user_index'

  # admin tools for item management
  resources :items

  # admin-only index page
  resources :admin, only: [:index]
  get '/admin/users', to: 'admin#users', as: 'admin_users'
  patch '/admin/set_role/:id', to: 'admin#set_role', as: 'set_role'
  get '/admin/reports', to: 'admin#sale_reports', as: 'sale_reports'
  post '/admin/reports', to: 'admin#generate_report', as: 'generate_report'


  # index page for gear sales is provided by the admin interface
  resources :gear_sales, only: [:new, :create, :edit, :update, :destroy]

  patch '/gear_sales/:id/toggle_active', to: 'gear_sales#toggle_active', as: 'toggle_sale_active'
  patch '/gear_sales/:id/toggle_open', to: 'gear_sales#toggle_open', as: 'toggle_sale_open'

  resources :loan_items
  post '/loan_items/:id/update_status', to: 'loan_items#update_status', as: 'update_loan_item_status'

  # user registration and management provided by Devise
  # all user management is done via SAML with a separate IdP, so we don't deal with
  # registration, editing, etc.
  devise_for :users

end
