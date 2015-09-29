Rails.application.routes.draw do

  root 'sessions#new'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'questions/matematica' => 'questions#matematica'
  get 'questions/natureza' => 'questions#natureza'
  get 'questions/humanas' => 'questions#humanas'
  get 'questions/linguagens' => 'questions#linguagens'
  get 'questions/all' => 'questions#index'

  get 'questions' => 'questions#category'

  resources :users
  resources :questions do
    member do
      post "answer"
    end
  end
end
