Rails.application.routes.draw do
  # get "tasks/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #the fact that its tasks instead of task means I probably named everything wrong and maybe should fix
  get "/tasks", to: "tasks#index", as: "tasks"

  get "/tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks", to: "tasks#create"

  get "/tasks/:id", to: "tasks#show", as: "task"

  get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  patch "tasks/:id", to: "tasks#update"

  delete "/tasks/:id", to: "tasks#destroy"

  root to: "tasks#index"
end
