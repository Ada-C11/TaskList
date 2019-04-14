Rails.application.routes.draw do
  # get "tasks/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #the fact that its tasks instead of task means I probably named everything wrong and maybe should fix
  # get "/tasks", to: "tasks#index", as: "tasks"

  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create"

  # get "/tasks/:id", to: "tasks#show", as: "task"

  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  # patch "tasks/:id", to: "tasks#update"

  # get "/tasks/:id/complete", to: "tasks#toggle_completion", as: "mark_complete"
  # patch "tasks/:id/complete", to: "tasks#toggle_completion"

  # get "tasks/:id/delete", to: "tasks#delete", as: "delete_task"
  # delete "/tasks/:id", to: "tasks#destroy"

  root to: "tasks#index"

  resources :tasks

  get "tasks/:id/delete", to: "tasks#delete", as: "delete_task"
  get "/tasks/:id/complete", to: "tasks#toggle_completion", as: "mark_complete"
  patch "tasks/:id/complete", to: "tasks#toggle_completion"
end
