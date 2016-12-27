Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :categories
    resources :languages
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
    resources :projects, only: [:new, :create, :edit, :update, :destroy]
    resources :metadata
    resources :images
    resources :users, except: [:show] do
      resources :userdetails, except: [:show]
    end
    get 'manageposts' => 'posts#manage'
    get 'manageprojects' => 'projects#manage'
    patch 'mark_image_as_main' => 'images#mark_as_main'
    patch 'move_image_up' => 'images#move_up'
    patch 'move_image_down' => 'images#move_down'
  end

  resources :posts, only: [:index, :show]

  patch 'likepost' => 'posts#like'
  get 'users/:id' => 'users#show'
  get 'me'        => 'users#show'
  get 'users/messages/:id' => 'users#message', :as => :message_user
  post 'users/sendmessage' => 'users#sendmessage', :as => :send_message_user
  resources :projects, only: [:index, :show]

  resources :projects do
    resources :posts, only: [:index]
  end

  root 'posts#index'

  # Redirect all error pages to the root path
  # get '*path' => 'posts#index'
end
