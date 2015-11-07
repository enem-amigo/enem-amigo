Rails.application.routes.draw do

  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'choose_exam' => 'static_pages#choose_exam'
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

  get 'medals' => 'medals#index'

  get 'random_exam' => 'exams#random_exam'
  get 'result' => 'exams#exam_result'

  resources :posts
  resources :comments

  post 'comments/create' => 'comments#create'

  resources :topics
  resources :posts do
    resources :comments
  end

  resources :users
  resources :questions do
    member do
      post 'answer'
      post 'next' => 'questions#next_question'
    end
  end

  resources :posts do
    member do
      post 'rate_post' => 'posts#rate_post'
    end
  end

  resources :comments do
    member do
      post 'rate_comment' => 'comments#rate_comment'
    end
  end

  get '*unmatched_route', :to => 'application#raise_not_found!'

end
