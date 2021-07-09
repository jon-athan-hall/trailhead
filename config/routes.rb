Rails.application.routes.draw do
  resources :users do
    collection do
      post 'confirm'
    end
  end

  resources :roles

  post 'auth/login', to: 'authentication#login'
end
