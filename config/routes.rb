Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users, only: %i[index show update] do
    member do
      patch :active
      patch :admin, to: 'admins#toggle'
    end

    collection do
      get :admins, to: 'admins#index'
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
      get :users
      get :articles
    end

    resources :users, only: [] do
      member do
        patch :admin, to: 'admins#toggle'
      end
    end

    resources :comments, only: %i[index create update destroy], controller: :comments

    resources :questions, only: %i[index create update destroy], controller: :questions do
      collection do
        get :pending
      end
    end
  end

  resources :articles, only: %i[index show create update destroy] do
    resources :likes, only: %i[index create destroy], controller: :likes
    resources :comments, only: %i[index create update destroy], controller: :comments
  end

  resources :categories, only: %i[index create update destroy]

  resources :comments, only: [] do
    resources :likes, only: %i[create destroy], controller: :likes
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
