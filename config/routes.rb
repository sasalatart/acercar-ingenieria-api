Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

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

    resources :comments, only: %i[index create update destroy], controller: :comments

    resources :questions, only: %i[index create update destroy], controller: :questions do
      collection do
        get :pending
      end
    end

    resources :enrollments, only: %i[create destroy]
  end

  resources :articles, only: %i[index show create update destroy] do
    delete :likes, to: 'likes#destroy'

    resources :likes, only: %i[create], controller: :likes
    resources :comments, only: %i[index create update destroy], controller: :comments
    resources :enrollments, only: %i[create destroy]
  end

  resources :categories, only: %i[index create update destroy]

  resources :comments, only: [] do
    delete :likes, to: 'likes#destroy'

    resources :likes, only: %i[create], controller: :likes
    resources :enrollments, only: %i[create destroy]
  end

  resources :discussions, only: %i[index show create update destroy] do
    delete :likes, to: 'likes#destroy'

    collection do
      get :mine
      get :pinned
    end

    resources :likes, only: %i[create], controller: :likes
    resources :comments, only: %i[index create update destroy], controller: :comments
    resources :enrollments, only: %i[create destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
