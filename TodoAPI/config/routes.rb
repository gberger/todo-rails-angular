TodoAPI::Application.routes.draw do
  namespace :api do
    resources :todos, except: [:new, :edit]

    post :users, to: 'users#create'

    post :sessions, to: 'sessions#create'
    delete :sessions, to: 'sessions#destroy'
  end
end
