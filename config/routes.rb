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
      put :seen, to: 'notifications#set_all_as_seen'
    end
  end

  resources :announcements, only: %i[index create update destroy] do
    collection { get :pinned }
  end

  resources :questions, only: %i[index create update destroy] do
    collection { get :unanswered }
  end

  resources :video_links, only: %i[update destroy]
  resources :categories, only: %i[index create update destroy]
  resources :credits, only: %i[index create update destroy]

  resources :articles, only: %i[index show create update destroy] do
    member { put :approval }

    collection do
      get :mine
      get :unapproved
    end

    post :reports, to: 'reports#report'
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index create]
  end

  resources :comments, only: %i[show update destroy] do
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index create]
  end

  resources :discussions, only: %i[index show create update destroy] do
    post :reports, to: 'reports#report'
    delete :likes, to: 'likes#destroy'
    delete :enrollments, to: 'enrollments#destroy'

    collection { get :mine }

    resources :likes, only: %i[create]
    resources :enrollments, only: %i[create]
    resources :comments, only: %i[index create]
  end

  resources :majors, only: %i[index show create update destroy] do
    member do
      post :email
      post 'personal-email'
      post :subscription, to: 'major_subscriptions#subscribe'
      delete :subscription, to: 'major_subscriptions#unsubscribe'
    end

    resources :admins, only: %i[index]

    resources :users, only: %i[index] do
      member do
        post :admin, to: 'admins#promote'
        delete :admin, to: 'admins#demote'
      end
    end

    resources :questions, only: %i[index create] do
      collection { get :unanswered }
    end

    resources :articles, only: %i[index create] do
      member { put :approval }

      collection do
        get :mine
        get :unapproved
      end
    end

    resources :video_links, only: %i[index create]
    resources :comments, only: %i[index create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
