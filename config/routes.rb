Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks

  patch "/tasks/:id/toggle_complete", to: "tasks#mark_complete", as: "mark_complete"
end
