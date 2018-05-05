require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'auth'

  post '/pusher/auth', to: 'pusher#auth'

  resources :admins, only: %i[index]
  resources :users, only: %i[index show update destroy] do
    member do
      post :admin, to: 'admins#promote'
      delete :admin, to: 'admins#demote'
    end
  end

  resources :notifications, only: %i[index] do
    collection do
      get :count
      get :seen
    end
  end

  resources :announcements, only: %i[index create update destroy] do
    collection do
      get :pinned
    end
  end

  resources :questions, only: %i[index create update destroy] do
    collection do
      get :pending
    end
  end

  resources :majors, only: %i[index show create update destroy] do
    member do
      post :email
      post 'personal-email'
    end

    resources :admins, only: %i[index]
    resources :users, only: %i[index] do
      member do
        post :admin, to: 'admins#promote'
        delete :admin, to: 'admins#demote'
      end
    end

    resources :video_links, only: %i[index create update destroy]
    resources :articles, only: %i[index show create update destroy]
    resources :comments, only: %i[index show create update destroy]

    resources :questions, only: %i[index create update destroy] do
      collection do
        get :pending
      end
    end
  end

  resources :articles, only: %i[index show create update destroy] do
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index show create update destroy]
  end

  resources :categories, only: %i[index create update destroy]

  resources :comments, only: %i[show] do
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index show create update destroy]
  end

  resources :discussions, only: %i[index show create update destroy] do
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    collection do
      get :mine
    end

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index show create update destroy]
  end

  resources :credits, only: %i[index create update destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
