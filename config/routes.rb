Rails.application.routes.draw do

  root 'static_pages#home'

  get 'sobre' => 'static_pages#about'
  get 'ajuda' => 'static_pages#help'

  get 'signup' => 'users#new'
  get 'ranking' => 'users#ranking'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'questions' => 'questions#category'
  get 'questions/all' => 'questions#index'
  get 'questions/humanas' => 'questions#humans'
  get 'questions/natureza' => 'questions#nature'
  get 'questions/linguagens' => 'questions#languages'
  get 'questions/matematica' => 'questions#math'
  post 'questions/upload'

  resources :users
  resources :questions do
    member do
      post "answer"
    end
  end
end
