Rails.application.routes.draw do
  get "/tasks", to: "tasks#index"
  # get "/tasks/:id", to: "tasks#show"
  get "/tasks/:id", to: "tasks#show", as: "task"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "tasks#index"
end
