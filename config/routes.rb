Rails.application.routes.draw do
  devise_for :users
  resources :wines, except: [:new, :edit]

  post 'auth_user' => 'authentication#authenticate_user'
end
