TodoAPI::Application.routes.draw do
  resources :todos, except: [:new, :edit]
end
