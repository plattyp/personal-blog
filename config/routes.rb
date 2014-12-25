Rails.application.routes.draw do

  devise_for :users

  authenticate :user do
    resources :categories
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
    resources :projects, only: [:new, :create, :edit, :update, :destroy]
    resources :metadata
    resources :images
    resources :users, except: [:show] do
      resources :userdetails, except: [:show]
    end
    get 'manageposts' => 'posts#manage'
    get 'manageprojects' => 'projects#manage'
  end

  resources :posts, only: [:index,:show]
  put 'likepost' => 'posts#like'
  get 'users/:id' => 'users#show'
  resources :projects, only: [:index,:show]

  resources :projects do
    resources :posts, only: [:index]
  end

  root 'posts#index'

  #Redirect all error pages to the root path
  #get '*path' => 'posts#index'
end
