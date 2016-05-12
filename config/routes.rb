Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
  resources :wines, except: [:new, :edit]
  end
end
