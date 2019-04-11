Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index', as: "tasks"

  get "/tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks/", to: "tasks#create" #tasks 

  get '/tasks/:id', to: 'tasks#show', as: "task"

  get '/tasks/:id/edit', to: 'tasks#edit', as: "edit_task"
  patch "/tasks/:id", to: "tasks#update" #path already has a name (task)
  delete "/tasks/:id", to: "tasks#destroy" #path already has a name (task)

  # mark a task as complete (not a RESTful route)
  patch "tasks/:id/completed", to: "tasks#mark_completed", as: "mark_completed"
  
  root to: "tasks#index" #makes the homepage for the site go to tasks#index 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
