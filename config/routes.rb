Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: 'homes#top'
  get 'about' => "homes#about"
  
  resources :books, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:show, :edit]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  
end
