Rails.application.routes.draw do
  resources :roles
  resources :users do
    collection do
      post 'confirm'
    end
  end
end
