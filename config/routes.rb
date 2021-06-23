Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :todos, only: [ :index, :show, :new, :create ] do
    patch :check, on: :member
    patch :prioritize, on: :member
    patch :unprioritize, on: :member
  end
end
