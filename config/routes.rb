Rails.application.routes.draw do
  root "tasks#index"
  put "/tasks/:id/toggle_completed", to: "tasks#toggle_completed", as: "toggle_completed_action"

  resources :tasks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/tasks", to: "tasks#index"
  # get "/tasks/:id", to: "tasks#show", as: "task"
end
