Rails.application.routes.draw do
  get 'home/about',as:'about'
  root to: 'home#top'

  devise_for :users

  post 'books' => 'books#create'

  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

  post 'users' => 'users#create'

  resources :books, only: [:new, :index, :show, :edit, :update]

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
