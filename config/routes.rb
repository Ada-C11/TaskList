Rails.application.routes.draw do
  get "/tasks", to: "tasks#index", as: "tasks"

  get "/tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks", to: "tasks#create"

  get "/tasks/:id", to: "tasks#show", as: "task"

  get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  patch "/tasks/:id", to: "tasks#update"

  delete "/tasks/:id", to: "tasks#destroy"

  patch "/tasks/:id/complete", to: "tasks#mark_complete", as: "mark_complete"

  root to: "tasks#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
