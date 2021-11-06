Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about',as: 'about'
  get '/search' =>  'searches#search'

  resources :books, only:[:index,:show,:create,:edit,:update,:destroy] do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end

  resources :users, only:[:index,:show,:edit,:update] do
    resource :relationships, only:[:create,:destroy] do
      collection do
        get :follow
        get :follower
      end
    end
  end

end