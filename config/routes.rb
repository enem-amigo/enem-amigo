Rails.application.routes.draw do

  root 'sessions#new'

  get 'signup' => 'users#new'
  get 'ranking' => 'users#ranking'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'questions' => 'questions#category'
  get 'questions/all' => 'questions#index'
  get 'questions/humanas' => 'questions#humanas'
  get 'questions/natureza' => 'questions#natureza'
  get 'questions/linguagens' => 'questions#linguagens'
  get 'questions/matematica' => 'questions#matematica'

  resources :users
  resources :questions do
    member do
      post "answer"
    end
  end
end
