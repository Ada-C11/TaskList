Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  patch "tasks/:id/complete", to: "tasks#toggle_complete", as: :complete_task
end
