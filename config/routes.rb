Rails.application.routes.draw do
  devise_for :users
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :wines, except: [:new, :edit]
  end

  get 'home' => 'home#index'

  post 'auth_user' => 'authentication#authenticate_user'
end
