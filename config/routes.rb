Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users, only: %i[index show update] do
    member do
      patch :active
      put :admin
    end

    collection do
      get :admins
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
      get :users
      get :admins
      get :articles
      get :questions
      get 'questions/pending', to: 'majors#pending_questions'
      put 'users/:user_id/admin', to: 'majors#admin'
    end
  end

  resources :articles, only: %i[index show create update destroy]
  resources :categories, only: %i[index create update destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
