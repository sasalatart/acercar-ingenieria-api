require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'auth'

  post '/pusher/auth', to: 'pusher#auth'

  resources :users, only: %i[index show update destroy] do
    member do
      post :admin, to: 'admins#create'
      delete :admin, to: 'admins#destroy'
    end

    collection do
      get :admins, to: 'admins#index'
    end
  end

  resources :notifications, only: %i[index] do
    member do
      patch :read
    end

    collection do
      get :count
      get :seen
      put :clear
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
    get :admins, to: 'admins#index'

    member do
      post :broadcast
    end

    resources :users, only: %i[index] do
      member do
        post :admin, to: 'admins#create'
        delete :admin, to: 'admins#destroy'
      end
    end

    resources :articles, only: %i[index show create update destroy]
    resources :comments, only: %i[index show create update destroy]

    resources :questions, only: %i[index create update destroy], controller: :questions do
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
