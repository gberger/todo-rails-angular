TodoAPI::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos, except: [:new, :edit]
    end
  end
end
