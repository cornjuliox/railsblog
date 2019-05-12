Rails.application.routes.draw do
  get 'users/new'
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do 
    resources :comments
  end

  resources :users

  root 'welcome#index'
end
