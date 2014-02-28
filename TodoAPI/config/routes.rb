TodoAPI::Application.routes.draw do
  namespace :api do
    resources :todos, except: [:new, :edit]

    post 'users/signup'
    post 'users/login'
    get 'users/me'

    put 'users/reset_api_key'
    patch 'users/reset_api_key'

    put 'users/change_password'
    patch 'users/change_password'
  end
end
