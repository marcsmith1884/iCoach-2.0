Rails.application.routes.draw do
  resources :locations
  resources :trainings
  devise_for :users, controllers: { 
  confirmations: 'users/confirmations', 
  omniauth_callbacks: 'users/omniauth_callbacks', 
  registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :destroy, :edit, :update] do
    member do
      patch :ban
  end 
end 
  
  root "static_pages#landing_page"
  # get 'static_pages/landing_page'
  # get 'static_pages/privacy_policy'
  get "privacy_policy", to: "static_pages#privacy_policy"
end
