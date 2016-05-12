Rails.application.routes.draw do
  resources :wines, except: [:new, :edit]
end
