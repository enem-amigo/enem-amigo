Rails.application.routes.draw do

  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'server_error' => 'static_pages#server_error'

  get 'signup' => 'users#new'
  get 'ranking' => 'users#ranking'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'questions' => 'questions#category'
  get 'questions/all' => 'questions#index'

  get 'questions/humans' => 'questions#humans'
  get 'questions/nature' => 'questions#nature'
  get 'questions/languages' => 'questions#languages'
  get 'questions/math' => 'questions#math'
  get 'questions/upload' => 'questions#new'
  post 'questions/upload_questions'
  post 'questions/upload_candidates_data'

  resources :users
  resources :questions do
    member do
      post 'answer'
      post 'next' => 'questions#next_question'
    end
  end

  get '*unmatched_route', :to => 'application#raise_not_found!'

end
