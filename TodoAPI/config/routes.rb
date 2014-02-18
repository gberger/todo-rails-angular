TodoAPI::Application.routes.draw do
  namespace :api do
    resources :todos, except: [:new, :edit]
    resources :sessions
    post :users, to: 'users#create'
  end
end
