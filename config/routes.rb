Rails.application.routes.draw do

  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'questions/category'
  get 'questions/select_category'

  resources :users
  resources :questions do
    member do
      post "answer"
    end
  end
end
