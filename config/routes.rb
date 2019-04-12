Rails.application.routes.draw do
  # root makes tasks#index the homepage
  root to: "tasks#index"

  # RESTful routes
  resources :tasks

  # mark a task as complete (not a RESTful route)
  patch "tasks/:id/toggle_complete", to: "tasks#toggle_complete", as: "toggle_complete"
end
