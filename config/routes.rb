Rails.application.routes.draw do
  devise_for :users
  resources :recipes do 
    collection do 
      get :pubrecipes
    end
  end
  root 'home#index'
  get 'home/index'
  get 'home/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end