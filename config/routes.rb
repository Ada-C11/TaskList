Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks

  get "tasks/:id/delete", to: "tasks#delete", as: "delete_task"
  get "/tasks/:id/complete", to: "tasks#toggle_completion", as: "mark_complete"
  patch "tasks/:id/complete", to: "tasks#toggle_completion"
end
