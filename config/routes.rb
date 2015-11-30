Rails.application.routes.draw do

  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'server_error' => 'static_pages#server_error'

  get 'signup' => 'users#new'
  get 'ranking' => 'users#ranking'
  get 'delete_profile_image' => 'users#delete_profile_image'
  get 'battles/ranking' => 'battles#ranking'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'questions' => 'questions#category'
  get 'questions/all' => 'questions#index'

  get 'questions/humans' => 'questions#humans'
  get 'questions/nature' => 'questions#nature'
  get 'questions/languages' => 'questions#languages'
  get 'questions/math' => 'questions#math'
  get 'questions/recommended' => 'questions#recommended'
  get 'questions/upload' => 'questions#new'
  post 'questions/upload_questions'
  post 'questions/upload_candidates_data'

  get 'medals' => 'medals#index'

  get '/generate_random_user', :to=>"battles#generate_random_user"

  get 'notifications' => 'notifications#index'

  get 'answer_exam' => 'exams#answer_exam'
  get 'select_exam' => 'exams#select_exam'
  get 'exam_result' => 'exams#exam_result'
  get 'exams_statistics' => 'exams#exams_statistics'
  delete 'cancel_exam' => 'exams#cancel_exam'

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

  resources :battles do
    member do
      post 'answer'
      get 'finish'
    end
  end

  resources :posts do
    member do
      get 'rate_post' => 'posts#rate_post'
    end
  end

  resources :comments do
    member do
      get 'rate_comment' => 'comments#rate_comment'
    end
  end

  resources :battles do
    member do
      get 'result' => 'battles#result'
    end
  end

  resources :notifications do
    get :read, on: :collection
  end

  get '*unmatched_route', :to => 'application#raise_not_found!'

end
